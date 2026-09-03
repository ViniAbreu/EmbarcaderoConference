import http from 'k6/http';
import { check } from 'k6';

export const options = {
  scenarios: {
    capacity: {
      // Usa o executor de taxa de chegada para achar o limite exato do sistema
      executor: 'ramping-arrival-rate',
      startRate: 10,
      timeUnit: '1s',
      preAllocatedVUs: 50,
      maxVUs: 500,
      stages: [
        { target: 100, duration: '1m' }, // Acelera suavemente para 100 reqs/segundo
        { target: 300, duration: '2m' }, // Acelera até 300 reqs/segundo
      ],
    },
  },
  thresholds: {
    // Aborta automaticamente o teste no momento em que a latência (p95) passar de 500ms
    http_req_duration: [{ threshold: 'p(95)<500', abortOnFail: true }],
  },
};

export default function () {
  const res = http.get('http://localhost:9000/ping');
  check(res, { 'status 200': (r) => r.status === 200 });
}
