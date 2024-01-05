import { Metrics } from '@aws-lambda-powertools/metrics';

import { unzipBase64 } from './functions/unzip-base64.mjs';
import { METRIC_NAMESPACE, METRIC_SERVICE_NAME } from './constants/index.mjs';

const metricResolution = 1;
const metricUnit = null;

export const handler = async (event) => {

  const decodedEvent = JSON.parse(await unzipBase64(event.awslogs.data));
  const alarmLogEvent = JSON.parse(decodedEvent.logEvents[0].message);
  console.log(alarmLogEvent);
  
  const metrics = new Metrics({
    namespace: METRIC_NAMESPACE,
    serviceName: METRIC_SERVICE_NAME,
  });

  const metricValue = alarmLogEvent.detail.state.value === "ALARM" ? 1 : 0;
  const singleMetric = metrics.singleMetric();

  singleMetric.addDimension('Alarm Name', alarmLogEvent.detail.alarmName);
  singleMetric.addMetric('Alarm State', metricUnit, metricValue, metricResolution);

  metrics.publishStoredMetrics();
};
