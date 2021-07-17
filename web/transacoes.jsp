<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.feevale.transacoes.*" %>
<%@page import="java.util.List" %>
<%@page import="java.lang.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Muita Grana: Transações</title>
        <link href="transacoes.css" rel="stylesheet" type="text/css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <img src="assets/money.png"/>
            <h1 class="titulo">Transações</h1>
       </header>
        <main>
            <div class="formularios">
                <div class="formulario">
                    <h3>Selecionar conta  </h2>
                    <form method="post">
                        <%
                            String stringNumeroConta = request.getParameter("numeroConta");
                            out.println("<input type=\"number\" name=\"numeroConta\" min=\"0\" value =" 
                                + stringNumeroConta + " required><br>");
                        %>
                        <input type="hidden" name="acao" value="conta">
                        <input type="submit" value="Selecionar" class="button" style="margin-top: 52px">
                    </form>
                </div>
                <div class="formulario">
                     <h3>Adicionar transação  </h2>
                    <form method="post">
                        <select id="operacao" name="operacao">
                            <option value="CREDITO">CREDITO</option>
                            <option value="DEBITO">DEBITO</option>
                        </select>
                        <input type="number" step="any" name="valor"  value="valor" min="0" required><br>
                        <input type="hidden" name="acao" value="insercao">
                        <%
                            out.println("<input type=\"hidden\" name=\"numeroConta\" min=\"0\" value =" 
                                + stringNumeroConta + "><br>");
                        %>
                        <input type="submit" value="Inserir" class="button">
                    </form>        
                </div>
            </div>

             <h3 class="titulo-tabela">Listagem de transações bancárias na conta </h2>
             <%
                final TransacaoDAO dao = TransacaoDAO.getInstance();
                Integer numeroConta = null;

                try {
                    numeroConta = Integer.parseInt(stringNumeroConta);
                } catch (Exception e) {}
                
                try {
                    if(request.getParameter("acao").equals("insercao")) {
                        final Transacao t = new Transacao();
                        t.setNumeroConta(numeroConta);
                        t.setOperacao(Operacao.valueOf(request.getParameter("operacao")));
                        t.setValor(Double.valueOf(request.getParameter("valor")));
                        dao.insert(t);
                    }
                } catch (Exception e) {}

                final List<Transacao> transacoes = dao.findByNumeroConta(numeroConta);
                Double saldo = 0.0;

                if(transacoes.isEmpty()) {
                    out.println("Não há transações a serem listadas!<br></main>");
                    return;
                }

                out.println("<table>");
                out.println("<tr>");
                out.println("<th style=\"border-radius: 7px 0 0 0\">ID</th>");
                out.println("<th>OPERACAO</th>");
                out.println("<th>VALOR</th>");
                out.println("<th style=\"border-radius: 0 7px 0 0\">DATA</th>");
                out.println("</tr>");

                for(int i=0; i < transacoes.size(); i++){
                    out.println("<tr>");
                    out.println("<td>");
                    out.println(transacoes.get(i).getId());
                    out.println("</td>");
                    out.println("<td>");
                    out.println(transacoes.get(i).getOperacao());
                    out.println("</td>");
                    out.println("<td>");
                    out.println(transacoes.get(i).getValor());
                    out.println("</td>");
                    out.println("<td>");
                    out.println(transacoes.get(i).getData());
                    out.println("</td>");
                    out.println("</tr>");

                    if(transacoes.get(i).getOperacao().equals(Operacao.CREDITO)) {
                        saldo = saldo + transacoes.get(i).getValor();
                    } else {
                        saldo = saldo - transacoes.get(i).getValor();
                    }
                }
                
                out.println("</table>");
                out.println("</main>");
                out.println(saldo > 0 ? 
                        "<footer>" : "<footer class=\"saldo-negativo\">");
                out.println("<span>");
                out.println("<b>Saldo da conta bancária: </b>R$" + saldo);
                out.println("</span>");
                out.println("</footer>");
            %>
    </body>
</html>