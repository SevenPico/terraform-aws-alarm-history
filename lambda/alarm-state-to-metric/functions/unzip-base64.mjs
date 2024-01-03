import zlib from 'zlib';

export function unzipBase64 (zippedBase4) {
  return new Promise((resolve, reject) => {
    const buffer = Buffer.from(zippedBase4, 'base64');
    zlib.gunzip(buffer, (err, decoded) => {
      if (err) {
        return reject(err);
      }
      resolve(decoded);
    });
  })
}
