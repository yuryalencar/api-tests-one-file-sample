*** Settings ***
Documentation         Curso Robot Do Zero to Hero
...
...                   Exemplo de automação de apis utilizando
...                   somente um arquivo

Library               Collections
Library               RequestsLibrary

*** Variables ***
${URL}                    https://my-json-server.typicode.com/yuryalencar/fake-api
${GET_EMPLOYEE_ID}        1
${DELETE_EMPLOYEE_ID}     2

*** Test Cases ***
Teste na Requisição GET para Empregados (StatusCode)
  GET                 ${URL}/employees     expected_status=200

Teste na Requisição GET para o Empregado Yury
  ${response}=        GET                 ${URL}/employees/${GET_EMPLOYEE_ID}            expected_status=200

  Should Be Equal As Strings              ${GET_EMPLOYEE_ID}                  ${response.json()}[id]
  Should Be Equal As Strings              Yury Alencar                        ${response.json()}[name]
  Should Be Equal As Strings              Automation & QA Tech Lead           ${response.json()}[job]
  Should Be Equal As Strings              07091238095                         ${response.json()}[document]

Teste na Requisição DELETE para o Empregado Gustavo (Status Code)
  DELETE              ${URL}/employees/${DELETE_EMPLOYEE_ID}      expected_status=200

Teste na Requisição DELETE para o Empregado Gustavo (Verificando 404 no GET)
  DELETE              ${URL}/employees/${DELETE_EMPLOYEE_ID}      expected_status=200
  GET                 ${URL}/employees/${DELETE_EMPLOYEE_ID}      expected_status=404

Teste na Requisição DELETE para o Empregado Gustavo (Verificando no GET da listagem)
  DELETE              ${URL}/employees/${DELETE_EMPLOYEE_ID}      expected_status=200
  ${response}=        GET                                         ${URL}/employees

  ${id_number}=       Convert To Integer    ${DELETE_EMPLOYEE_ID}
  &{employee_dict}=   Create Dictionary     id=${id_number}       name=Gustavo Satheler   job=Full Cycle Lead     document=20874135095

  List Should Not Contain Value             ${response.json()}    ${employee_dict}
