package br.com.mynerp.persistencia.dao;

import java.util.List;

import br.com.mynerp.persistencia.Cobranca;
import br.com.mynerp.persistencia.CondicaoPagamento;
import br.com.mynerp.persistencia.CondicaoParcela;
import br.com.mynerp.persistencia.dao.exception.ListaTabelasNaoEncontradoException;

public interface IListaTabelasDAO {
	
	/*Cobranca*/
	public List<Cobranca> obterCobrancas(Integer idPagarReceber) throws ListaTabelasNaoEncontradoException;	
	public Cobranca obterCobranca (int id) throws ListaTabelasNaoEncontradoException;
	
	public Cobranca inserirCobranca (Cobranca cobranca);	
	public Cobranca alterarCobranca (Cobranca cobranca);	
	public void removerCobranca (Cobranca cobranca);	
	
	/*Condi�ao Pagamento*/ 
	public List<CondicaoPagamento> obterCondicoesPagamento(Integer idPagarReceber, boolean isEager) throws ListaTabelasNaoEncontradoException;	
	public CondicaoPagamento obterCondicaoPagamento (int id, boolean isEager) throws ListaTabelasNaoEncontradoException;	
	public CondicaoPagamento inserirCondicaoPagamento (CondicaoPagamento condicao);	
	public CondicaoPagamento alterarCondicaoPagamento (CondicaoPagamento condicao);	
	public void removerCondicaoPagamento (CondicaoPagamento condicao);
	public List<CondicaoParcela> parcelasCondicaoPagamento(int idCondicao)throws ListaTabelasNaoEncontradoException;
	

}