from flask import Flask, request

from oidc_server import authenticate, clients, token, userinfo

# Initialize Flask application
app = Flask(__name__)

# Define authentication endpoint
@app.route("/authentication", methods=["POST"])
def authentication():
    return authenticate(request.form.get("username"), request.form.get("password"))


# Define token endpoint
@app.route("/token", methods=["POST"])
def token_route():
    return token()


# Define userinfo endpoint
@app.route("/userinfo", methods=["GET"])
def userinfo_route():
    return userinfo()


# Define clients endpoint
@app.route("/clients", methods=["GET"])
def clients_route():
    return clients()


# Run the Flask application
if __name__ == "__main__":
    app.run(debug=True)
