# POC

POC realizada para validar o fluxo do LDAP Group Provider. 

- O fluxo é LDAP plugin dentro do Trino faz requisição de usuário ao LDAP e o LDAP retorna o usuário e uma lista de grupos a que ele pertence, esse plugin como parte de sua funcionalidade assinala esse usuários aos grupos do File Based Access Control para que seja utilizado como critério de regra de acesso a catalogos, schemas ou tabelas.
### O que foi feito

Durante o primeiro teste subi um Openldap junto do Trino em docker-compose depois joguei o plugin do ldap dentro do trino, para garantir a conexão entre o Openldap e o Trino. 

Ainda na configuração do docker-compose configurei  dentro do trino o File Based Access Control, que faria o bloqueio de usuários aos catálogos de acordo com o grupo. O fluxo foi testado, e foi visto a necessidade de trocar de Openldap para Freeipa, já que o Openldap não nos retornava um usuário como memberof, no caso esse memberof é necessário para o plugin entender a que grupo o usuário pertence.

Subindo o Freeipa de um estudo   configurei o usuário para um grupo chamado company, e configurei o File Based Access Control para que permitisse a visão de certo catalogo para usuários de grupo company, apesar de dessa vez a query vinda do plugin tenha sido entendida e retornado valores correspondentes a nome da usuário e a que grupo ele pertence, ainda assim o Trino não consegue fazer o matching entre o grupo que vem do Freeipa e a regra assinalada ao grupo que esta dentro do File Based Access Control.

### Validando o fluxo de File Based Access Control

Para validar se o File Based Access Control estava funcionando como esperado, subi um File Group Provider substituindo o LDAP Group Provider, assinalando os usuários aos grupos dentro de um arquivo chamado group.txt. O fluxo funcionou perfeitamente e nessa parte podemos dizer que não há problemas.