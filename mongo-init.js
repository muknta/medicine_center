db.createUser(
    {
        user: "user-admin",
        pwd: "mongo",
        roles: [
            {
                role: "readWrite",
                db: "med"
            }
        ]
    }
);
