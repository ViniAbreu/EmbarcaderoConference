import http from 'k6/http';
import { check, sleep } from 'k6';

// Stress Test (Estresse) - Leva o sistema além do limite estabelecido para achar o ponto de ruptura
export const options = {
  stages: [
    { duration: '1m', target: 100 },
    { duration: '1m', target: 300 },
    { duration: '1m', target: 600 },
    { duration: '1m', target: 1000 }, // Neste ponto os erros (500) devem começar a aparecer no terminal
  ]
};

export default function () {
  const res = http.get('http://localhost:9000/heavy');
  
  check(res, {
    'status é 200': (r) => r.status === 200,
  });
  
  sleep(1);
}
