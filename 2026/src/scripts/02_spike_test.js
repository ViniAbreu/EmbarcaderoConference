import http from 'k6/http';
import { check, sleep } from 'k6';

// Spike Test (Pico) - Aumento súbito e extremo de tráfego
export const options = {
  stages: [
    { duration: '10s', target: 10 },   // uso normal
    { duration: '20s', target: 10000 }, // SPIKE! Multidão acessando de uma vez
    { duration: '10s', target: 10 },   // recuperação
  ]
};

export default function () {
  const res = http.get('http://localhost:9000/heavy');

  check(res, {
    'status é 200': (r) => r.status === 200,
  });

  sleep(1);
}
