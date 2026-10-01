const { query } = require('../database');

exports.listarformaPagamento = async (req, res) => {
    try {
        const result = await query('SELECT * FROM public.forma_pagamento ORDER BY id_forma_pagamento');
        res.json({ sucesso: true, forma_pagamentos: result.rows });
    } catch (error) {
        console.error('Erro ao listar formas de pagamento:', error);
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao listar formas de pagamento.' });
    }
};

exports.obterformaPagamento = async (req, res) => {
    try {
        const id = Number(req.params.id);
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'ID inválido.' });
        const result = await query('SELECT * FROM public.forma_pagamento WHERE id_forma_pagamento = $1', [id]);
        if (!result.rowCount) return res.status(404).json({ sucesso: false, mensagem: 'Forma de pagamento não encontrada.' });
        res.json({ sucesso: true, forma_pagamento: result.rows[0] });
    } catch (error) {
        console.error('Erro ao obter forma de pagamento:', error);
        res.status(500).json({ sucesso: false, mensagem: 'Erro interno do servidor.' });
    }
};

exports.criarformaPagamento = async (req, res) => {
    try {
        const id = Number(req.body.id_forma_pagamento);
        const nome = String(req.body.nome_forma_pagamento || '').trim();
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'O ID deve ser um número inteiro positivo.' });
        if (!nome) return res.status(400).json({ sucesso: false, mensagem: 'O nome da forma de pagamento é obrigatório.' });
        const result = await query('INSERT INTO public.forma_pagamento (id_forma_pagamento, nome_forma_pagamento) VALUES ($1, $2) RETURNING *', [id, nome]);
        res.status(201).json({ sucesso: true, mensagem: 'Forma de pagamento inserida com sucesso!', forma_pagamento: result.rows[0] });
    } catch (error) {
        console.error('Erro ao criar forma de pagamento:', error);
        if (error.code === '23505') return res.status(400).json({ sucesso: false, mensagem: 'Este ID já está cadastrado.' });
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao inserir forma de pagamento.' });
    }
};

exports.atualizarformaPagamento = async (req, res) => {
    try {
        const id = Number(req.params.id);
        const nome = String(req.body.nome_forma_pagamento || '').trim();
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'ID inválido.' });
        if (!nome) return res.status(400).json({ sucesso: false, mensagem: 'O nome da forma de pagamento é obrigatório.' });
        const result = await query('UPDATE public.forma_pagamento SET nome_forma_pagamento = $1 WHERE id_forma_pagamento = $2 RETURNING *', [nome, id]);
        if (!result.rowCount) return res.status(404).json({ sucesso: false, mensagem: 'Forma de pagamento não encontrada.' });
        res.json({ sucesso: true, mensagem: 'Forma de pagamento alterada com sucesso!', forma_pagamento: result.rows[0] });
    } catch (error) {
        console.error('Erro ao atualizar forma de pagamento:', error);
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao atualizar forma de pagamento.' });
    }
};

exports.deletarformaPagamento = async (req, res) => {
    try {
        const id = Number(req.params.id);
        if (!Number.isInteger(id) || id <= 0) return res.status(400).json({ sucesso: false, mensagem: 'ID inválido.' });
        await query('DELETE FROM public.forma_pagamento WHERE id_forma_pagamento = $1', [id]);
        res.json({ sucesso: true, mensagem: 'Forma de pagamento excluída com sucesso!' });
    } catch (error) {
        console.error('Erro ao deletar forma de pagamento:', error);
        if (error.code === '23503') return res.status(400).json({ sucesso: false, mensagem: 'Não é possível excluir: existem pagamentos associados a esta forma.' });
        res.status(500).json({ sucesso: false, mensagem: 'Erro ao excluir forma de pagamento.' });
    }
};
