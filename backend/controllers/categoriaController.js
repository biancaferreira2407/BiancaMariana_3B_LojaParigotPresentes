const { query } = require('../database');

exports.listarCategorias = async (req, res) => {
    try {
        const result = await query('SELECT * FROM public.categoria ORDER BY id_categoria');
        res.json({ sucesso: true, categorias: result.rows });
    } catch (error) {
        console.error('Erro ao listar categorias:', error);
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao listar categorias.' });
    }
};

exports.obterCategoria = async (req, res) => {
    try {
        const id = Number(req.params.id);
        if (!Number.isInteger(id) || id <= 0) {
            return res.status(400).json({ sucesso: false, mensagem: 'ID inválido.' });
        }
        const result = await query('SELECT * FROM public.categoria WHERE id_categoria = $1', [id]);
        if (result.rows.length === 0) return res.status(404).json({ sucesso: false, mensagem: 'Categoria não encontrada.' });
        res.json({ sucesso: true, categoria: result.rows[0] });
    } catch (error) {
        console.error('Erro ao obter categoria:', error);
        res.status(500).json({ sucesso: false, mensagem: 'Erro interno do servidor.' });
    }
};

exports.criarCategoria = async (req, res) => {
    try {
        const id = Number(req.body.id_categoria);
        const nome = String(req.body.nome_categoria || '').trim();
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'O ID da categoria deve ser um número inteiro positivo.' });
        if (!nome) return res.status(400).json({ sucesso: false, mensagem: 'O nome da categoria é obrigatório.' });
        const result = await query('INSERT INTO public.categoria (id_categoria, nome_categoria) VALUES ($1, $2) RETURNING *', [id, nome]);
        res.status(201).json({ sucesso: true, mensagem: 'Categoria inserida com sucesso!', categoria: result.rows[0] });
    } catch (error) {
        console.error('Erro ao criar categoria:', error);
        if (error.code === '23505') return res.status(400).json({ sucesso: false, mensagem: 'Este ID já está cadastrado.' });
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao inserir categoria no banco de dados.' });
    }
};

exports.atualizarCategoria = async (req, res) => {
    try {
        const id = Number(req.params.id);
        const nome = String(req.body.nome_categoria || '').trim();
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'ID inválido.' });
        if (!nome) return res.status(400).json({ sucesso: false, mensagem: 'O nome da categoria é obrigatório.' });
        const result = await query('UPDATE public.categoria SET nome_categoria = $1 WHERE id_categoria = $2 RETURNING *', [nome, id]);
        if (result.rows.length === 0) return res.status(404).json({ sucesso: false, mensagem: 'Categoria não encontrada.' });
        res.json({ sucesso: true, mensagem: 'Categoria alterada com sucesso!', categoria: result.rows[0] });
    } catch (error) {
        console.error('Erro ao atualizar categoria:', error);
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao atualizar categoria.' });
    }
};

exports.deletarCategoria = async (req, res) => {
    try {
        const id = Number(req.params.id);
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'ID inválido.' });
        const result = await query('DELETE FROM public.categoria WHERE id_categoria = $1 RETURNING id_categoria', [id]);
        if (result.rowCount === 0) return res.status(404).json({ sucesso: false, mensagem: 'Categoria não encontrada.' });
        res.json({ sucesso: true, mensagem: 'Categoria excluída com sucesso!' });
    } catch (error) {
        console.error('Erro ao deletar categoria:', error);
        if (error.code === '23503') return res.status(400).json({ sucesso: false, mensagem: 'Não é possível excluir: existem produtos associados a esta categoria.' });
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao excluir categoria.' });
    }
};
