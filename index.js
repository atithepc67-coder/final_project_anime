const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// ข้อมูลอนิเมะของเรา
const animeList = [
  {
    "id": 1,
    "name": "Solo Leveling",
    "detail": "ในโลกที่มีมอนสเตอร์และฮันเตอร์ ซองจินอู ฮันเตอร์ระดับ E ที่อ่อนแอที่สุด ได้รับพลังพิเศษจากระบบลึกลับที่ทำให้เขาสามารถอัปเลเวลตัวเองได้เพียงคนเดียว",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1160/141088.jpg",
    "rating": "9.1",
    "episodes": "12"
  },
  {
    "id": 2,
    "name": "Jujutsu Kaisen",
    "detail": "อิตาโดริ ยูจิ เด็กหนุ่มมัธยมปลายที่มีพละกำลังมหาศาล ได้กลืนนิ้วของ สุคุนะ ราชาคำสาป เพื่อช่วยเพื่อน ทำให้เขาต้องก้าวเข้าสู่โลกของนักคุณไสย",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1127/127111.jpg",
    "rating": "8.8",
    "episodes": "47"
  },
  {
    "id": 3,
    "name": "Demon Slayer",
    "detail": "คามาโดะ ทันจิโร่ เด็กหนุ่มขายถ่านที่ครอบครัวถูกอสูรฆ่าตาย และน้องสาวกลายเป็นอสูร เขาจึงเข้าร่วมหน่วยพิฆาตอสูรเพื่อหาทางรักษาน้องสาว",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1286/99889.jpg",
    "rating": "8.9",
    "episodes": "55"
  },
  {
    "id": 4,
    "name": "Attack on Titan",
    "detail": "มนุษยชาติต้องอาศัยอยู่หลังกำแพงขนาดยักษ์เพื่อป้องกันตัวเองจาก ไททัน สิ่งมีชีวิตขนาดยักษ์ที่กินมนุษย์ เอเรน เยเกอร์ สาบานว่าจะกำจัดพวกมันให้หมดสิ้น",
    "coverimage": "https://cdn.myanimelist.net/images/anime/10/47347.jpg",
    "rating": "9.0",
    "episodes": "89"
  },
  {
    "id": 5,
    "name": "Spy x Family",
    "detail": "สนธยา สปายยอดฝีมือต้องสร้างครอบครัวปลอมๆ เพื่อทำภารกิจ โดยไม่รู้ว่าภรรยาเป็นนักฆ่า และลูกสาวบุญธรรมเป็นผู้มีพลังจิตอ่านใจได้",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1441/122795.jpg",
    "rating": "8.6",
    "episodes": "25"
  }
];

// เพิ่ม 3 บรรทัดนี้ เพื่อบอก Vercel ว่าเว็บเราทำงานปกตินะ
app.get('/', (req, res) => {
  res.status(200).send("API is running! Go to /api/anime");
});

// Endpoint สำหรับดึงข้อมูลอนิเมะ
app.get('/api/anime', (req, res) => {
  res.status(200).json(animeList);
});

// ให้ start server เฉพาะเมื่อไม่ใช่ production (ตามสไลด์อาจารย์)
if (process.env.NODE_ENV !== 'production') {
  const PORT = 3333;
  app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}

// 🌟 สิ่งสำคัญ: Export app สำหรับ deploy บน Vercel
module.exports = app;