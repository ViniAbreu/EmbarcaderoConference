import http from 'k6/http';
import { check, sleep } from 'k6';

// Soak Test (Imersão) - Carga moderada por um longo período de tempo
export const options = {
  stages: [
    { duration: '5m', target: 100 }, // ramp up
    { duration: '8h', target: 100 }, // mantém carga por 8 horas para caçar Memory Leaks!
    { duration: '5m', target: 0 },   // ramp down
  ]
};

export default function () {
  const res = http.get('http://localhost:9000/leak');
  
  check(res, {
    'status é 200': (r) => r.status === 200,
  });
  
  sleep(1);
}
