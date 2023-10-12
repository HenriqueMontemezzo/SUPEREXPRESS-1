// routes/users.js

const express = require('express');
const router = express.Router();
const db = require('../database/mysql').pool;

// Função para buscar um usuário específico do banco de dados
async function getUserFromDatabase(userId) {
  return new Promise((resolve, reject) => {
    db.getConnection((err, conn) => {
      if (err) {
        reject(err);
      }

      conn.query(
        'SELECT * FROM projetotcc.login WHERE user_id = ?', [userId],
        (error, results, fields) => {
          conn.release();
          if (error) {
            reject(error);
          }

          resolve(results[0]); // Retorna o usuário correspondente ao ID
        }
      );
    });
  });
}

// Rota para buscar um usuário específico
router.get('/users/:id', async (req, res, next) => {
  try {
    const user = await getUserFromDatabase(req.params.id); // Chame a função para obter o usuário do banco de dados
    res.status(200).json({ message: 'Usuário encontrado', data: user });
  } catch (error) {
    console.log(error); // Imprime o erro no console
    res.status(500).json({ error: 'Erro ao buscar usuário' });
  }
});

module.exports = router;
