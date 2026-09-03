import http from 'k6/http';
import { check, sleep } from 'k6';

// Load Test (Carga) - Valida o comportamento sob uso real e rotineiro
export const options = {
  stages: [
    { duration: '30s', target: 50 }, // sobe gradualmente para 50 VUs (Virtual Users)
    { duration: '1m', target: 50 },  // mantém estável
    { duration: '30s', target: 0 },  // desce gradualmente
  ]
};

export default function () {
  const res = http.get('http://localhost:9000/ping');
  
  check(res, {
    'status é 200': (r) => r.status === 200,
  });
  
  sleep(1);
}
