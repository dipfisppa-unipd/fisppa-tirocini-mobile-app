# unipd_mobile

Scienze della formazione primaria ciclo completo


## Branches

La libreria dart:html che consente l'SSO su browser va commentata prima di buildare mobile.


# Authorization

- /api/auth/refresh     401 Unauthorized se non può fare refresh dell accessToken
- /api/*                403 Forbidden se accessToken scaduto


# Indirect internship

## /internship/indirect

Ritornerà un array con i tirocini richiesti (indiretti).
Quindi per un utente che è al primo anno l'array sarà vuoto.

Per gli studenti di anni precedenti che devono inserire lo storico,
l'array risulterà anch'esso vuoto e sarà quindi possibile per loro inserire
anni precedenti.