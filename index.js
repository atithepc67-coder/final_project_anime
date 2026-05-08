const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// ข้อมูลอนิเมะฉบับอัปเดต (English Version + Stable Images)
const animeList = [
  {
    "id": 1,
    "name": "Solo Leveling",
    "detail": "In a world where hunters battle deadly monsters to protect mankind, Sung Jinwoo, known as the weakest hunter of all mankind, discovers a mysterious system that allows him to level up infinitely.",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1015/138006.jpg",
    "rating": "9.1",
    "episodes": "12"
  },
  {
    "id": 2,
    "name": "Jujutsu Kaisen",
    "detail": "Yuji Itadori, a high school student with extraordinary physical abilities, swallows a cursed finger to save his friends. He joins the Tokyo Jujutsu High School to fight against Curses and find the remaining fingers of Sukuna.",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1171/109222.jpg",
    "rating": "8.8",
    "episodes": "47"
  },
  {
    "id": 3,
    "name": "Demon Slayer",
    "detail": "Tanjiro Kamado joins the Demon Slayer Corps to find a cure for his sister, Nezuko, who has been turned into a demon, and to avenge his family who were slaughtered by Muzan Kibutsuji.",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1286/99889.jpg",
    "rating": "8.9",
    "episodes": "55"
  },
  {
    "id": 4,
    "name": "Attack on Titan",
    "detail": "Humanity lives inside cities surrounded by enormous walls that protect them from Titans, gigantic human-eating humanoids. Eren Yeager vows to retake the world after a Titan destroys his hometown.",
    "coverimage": "https://cdn.myanimelist.net/images/anime/10/47347.jpg",
    "rating": "9.0",
    "episodes": "89"
  },
  {
    "id": 5,
    "name": "Spy x Family",
    "detail": "A spy on an undercover mission gets married and adopts a child as part of his cover. However, his wife is a deadly assassin and his daughter is a telepath, and none of them know each other's secrets.",
    "coverimage": "https://cdn.myanimelist.net/images/anime/1441/122795.jpg",
    "rating": "8.6",
    "episodes": "25"
  }
];

// หน้าแรกสำหรับเช็กว่า Server ทำงานไหม
app.get('/', (req, res) => {
  res.status(200).send("Anime API is running! Access the data at /api/anime");
});

// Endpoint สำหรับดึงข้อมูลอนิเมะ
app.get('/api/anime', (req, res) => {
  res.status(200).json(animeList);
});

// เริ่มต้น Server (เฉพาะเมื่อไม่ได้รันบน Vercel)
if (process.env.NODE_ENV !== 'production') {
  const PORT = 3333;
  app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}

// Export สำหรับ Vercel
module.exports = app;