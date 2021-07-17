package br.feevale.transacoes;

import java.sql.Date;

/**
 *
 * @author Nicole
 */
public class Transacao {
    
    private Integer id;
    private Integer numeroConta;
    private Operacao operacao;
    private Double valor;
    private Date data;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the numeroConta
     */
    public Integer getNumeroConta() {
        return numeroConta;
    }

    /**
     * @param numeroConta the numeroConta to set
     */
    public void setNumeroConta(Integer numeroConta) {
        this.numeroConta = numeroConta;
    }

    /**
     * @return the operacao
     */
    public Operacao getOperacao() {
        return operacao;
    }

    /**
     * @param operacao the operacao to set
     */
    public void setOperacao(Operacao operacao) {
        this.operacao = operacao;
    }
    
    /**
     * @return the valor
     */
    public Double getValor() {
        return valor;
    }

    /**
     * @param valor the valor to set
     */
    public void setValor(Double valor) {
        this.valor = valor;
    }
    
     /**
     * @return the data
     */
    public Date getData() {
        return data;
    }

    /**
     * @param data the data to set
     */
    public void setData(Date data) {
        this.data = data;
    }
    
    @Override
    public String toString() {
        return id + " - " + numeroConta + " - " + operacao + " - " + valor 
                + " - " + data;
    }
    
}
