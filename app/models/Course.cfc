component {
    function search(required string searchQuery) {
        return queryExecute(
            "
                SELECT
                    id,
                    title,
                    description
                FROM classes
                WHERE title LIKE :search
                   OR description LIKE :search
                ORDER BY title
            ",
            {
                search: {
                    value: "%" & arguments.searchQuery & "%",
                    cfsqltype: "varchar"
                }
            }
        );
    }
}