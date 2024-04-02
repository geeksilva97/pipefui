# Desafio Trainees - Semana 12

## Notas Importantes

- Precisa funcionar
- Testes são obrigatórios (unitarios, request e e2e)
- Precisa estar deployado no Render
- Usar JavaScript não é necessário, fica a seu critério. Tudo pode ser feito com Rails e ERB.

O desafio consiste na implementação de um criador de formulários

## Task 1 - Dashboard para criação do form

Aqui teremos basicamente um CRUD no formulário. O formulário deve possuir um título e uma lista de campos.

Você pode organizar as rotas como achar melhor, mas aqui vai uma sugestão:

- `dashboard/form` - lista os forms criados
- `dashboard/form/new` - renderiza o template para a criação de um novo form
- `dashboard/form/:formid/edit` - renderiza o template para a edição de um form

Acima estão as ações que têm templates. Naturalmente, as que performam ações apenas também devem existir. Ação de `update`, `create` e `delete`.

## Task 2 - Recebimento de respostas no form criado

Os formulários criados devem estar aptos a receber respostas. De novo, organize as rotas como quiser. Mas como
sugestões:

- `/:formid` renderiza o form para respostas; isso significa renderizar os campos que foram adicionados pelo dashboard.
    assim, campos de texto longo devem ser renderizados como `textarea` e campos de texto curto `<input type="text" />`

## Task 3 - Visualização de respostas no dashboard

Respostas enviadas nos formulários devem ser possíveis de ser visualizadas no dashboard.

- `dashboard/form/:formid/answers` - lista de respostas recebidas em um form específico;
    - aqui deve mostrar só um preview das respostas. Algo como o primeiro campo do form e seu valor
    - deve have um link pra mostrar aquela resposta completa que vai levar para uma rota tal qual: `dashboard/form/:formid/answers/:answerid`


## Extras

Caso queira se divertir. Você pode:

- adicionar uma flag aos campos, determinando se são obrigatórios ou não. Essa validação deve ser obedecida quando
    o form for preenchido
- adicionar uma flag ao form em si para determinar se aquele form ainda está recebendo respostas.
- dividir o formulário em seções/páginas
- envio de email das respostas. ex: ao preencher o formulario, informo meu email, assim, ao terminar de preencher recebo
    um email com uma cópia das respostas.
