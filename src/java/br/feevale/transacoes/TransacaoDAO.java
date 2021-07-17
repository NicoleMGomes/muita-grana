package br.feevale.transacoes;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nicole
 */
public class TransacaoDAO {
    
    String uri = "jdbc:derby://localhost:1527/muita_grana";
    Connection con = null;
    private static TransacaoDAO instance = null;
    
    public static synchronized TransacaoDAO getInstance() { 
       
        if (instance == null) {
            instance = new TransacaoDAO();
        }
        
        return instance;
    }

    private TransacaoDAO() {
        connect();
    }
    
    private void connect() {
        
        try {
            con = DriverManager
                    .getConnection(uri, "muita_grana", "muita_grana");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Transacao> findByNumeroConta(final Integer numeroConta) {
        
        final String sql = "SELECT * FROM TRANSACAO WHERE NUMERO_CONTA = ? "
                + "ORDER BY DATA";
        final List<Transacao> transacoes = new ArrayList<>();
        Transacao transacao;
        
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, numeroConta);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                transacao = new Transacao();
                transacao.setId(rs.getInt("ID"));
                transacao.setNumeroConta(rs.getInt("NUMERO_CONTA"));
                transacao.setOperacao(Operacao.valueOf(rs.getString("OPERACAO")));
                transacao.setValor(rs.getDouble("VALOR"));
                transacao.setData(rs.getDate("DATA"));
                transacoes.add(transacao);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return transacoes;
    }
    
    public void insert(final Transacao a) {
        
        final String sql = "INSERT INTO TRANSACAO "
                + "(NUMERO_CONTA, OPERACAO, VALOR, DATA) VALUES (?, ?, ?, ?)";
        
        try {
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, a.getNumeroConta());
            pstmt.setString(2, a.getOperacao().name());
            pstmt.setDouble(3, a.getValor());
            pstmt.setDate(4, Date.valueOf(LocalDate.now()));
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
