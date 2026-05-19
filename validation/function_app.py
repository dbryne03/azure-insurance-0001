import json
import logging
import azure.functions as func
from hash_engine import hash_resultset, compare_hashes

logger = logging.getLogger(__name__)
app = func.FunctionApp()


@app.function_name("ValidateTable")
@app.route(route="validate/{table_name}", methods=["POST"])
def validate_table(req: func.HttpRequest) -> func.HttpResponse:
    table_name = req.route_params.get("table_name")

    try:
        body = req.get_json()
        pk_column = body.get("pk_column", "id")
        columns = body.get("columns", [])
    except ValueError:
        return func.HttpResponse("Invalid request body", status_code=400)

    # TODO: fetch source rows from PostgreSQL
    source_rows: list[dict] = []

    # TODO: fetch target rows from Azure SQL
    target_rows: list[dict] = []

    source_hashes = hash_resultset(source_rows, pk_column, columns)
    target_hashes = hash_resultset(target_rows, pk_column, columns)
    result = compare_hashes(source_hashes, target_hashes)

    # TODO: write result to reconciliation tables in Azure SQL

    logger.info(
        "Validation complete — table: %s, matched: %d, mismatched: %d",
        table_name,
        result["matched"],
        len(result["mismatched"]),
    )

    return func.HttpResponse(json.dumps(result), mimetype="application/json")
