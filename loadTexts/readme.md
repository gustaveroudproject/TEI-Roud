# Load texts


### Option 1

Request in Postman to post newResource
https://docs.knora.org/03-apis/api-v2/editing-resources.html
It will complain about wrong properties ... don't know why but seems to work anyway.


### Option 2

Bulk import. `curl -X POST -d @bulkImport_1927_Adieu.xml http://root%40example.com:test@localhost:3333/v1/resources/xmlimport/http%3A%2F%2Frdfh.ch%2Fprojects%2F0112`


### To check the created resource

In the browser look for `http://0.0.0.0:3333/v2/resources/URI` (encode URI). Example: `http://0.0.0.0:3333/v2/resources/http%3A%2F%2Frdfh.ch%2F0112%2FVply6mleRkeZ7JZQsYsNVw`

**Attention**: `get resource` v1 gives back source, while `get resource v2` gives back textValueAsHtml.


### Resources
- Knora bulk import, see https://github.com/LaDHUL/KnoraBulkStandoffImport#prepare-bulk-import
- HTTP POST, see https://docs.knora.org/03-apis/api-v2/editing-values/#creating-a-value and in particular https://docs.knora.org/03-apis/api-v2/editing-values/#creating-a-text-value-with-standoff-markup.
