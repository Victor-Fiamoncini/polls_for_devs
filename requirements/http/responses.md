# HTTP

## Sucesso

1. ✔️ Request com verbo válido (POST)
2. ✔️ Passar nos headers o "content-type JSON"
3. ✔️ Chamar request com Body correto
4. ✔️ Ok - 200 e resposta com dados
5. ✔️ No content - 204 e resposta sem dados

## Erros

1. ✔️ Bad request - 400
2. ✔️ Unauthorized - 401
3. ✔️ Forbidden - 403
4. ✔️ Not Found - 404
5. ✔️ Internal Server Error - 500

## Exceção - Status code diferente dos citados acima

1. ✔️ Internal Server Error - 500

## Exceção - HTTP request deu alguma exceção

1. Internal Server Error - 500

## Exceção - Verbo HTTP inválido

1. Internal Server Error - 500
