import { Metrics } from '@aws-lambda-powertools/metrics';

import { METRIC_NAMESPACE, METRIC_SERVICE_NAME } from './constants/index.mjs';

const metricResolution = 1;
const metricUnit = null;

export const handler = async (event) => {
  const metrics = new Metrics({
    namespace: METRIC_NAMESPACE,
    serviceName: METRIC_SERVICE_NAME,
  });

  const metricValue = event.detail.state.value === "ALARM" ? 1 : 0;
  const singleMetric = metrics.singleMetric();

  singleMetric.addDimension('Alarm Name', event.detail.alarmName);
  singleMetric.addMetric('Alarm State', metricUnit, metricValue, metricResolution);

  metrics.publishStoredMetrics();
};
