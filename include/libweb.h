/*
 *  This is the file that defines our structures used in our functions, here
 *  we have the cryptographic key, encrypting requests; the request struct
 *  to hold the information pertaining to a request; and the response struct
 *  holding the response information.
 */

#ifndef LIBWEB_H
#define LIBWEB_H

/*
 * Objects definitions
 */

/* Our structure that contains the response's data */
struct response {
	int status;
	char *type;
	char *path;
	char *vers;
	char *serv;
	char *conn;
	char *auth;
	char *key;
	char *cenc;
	int clen;
	char *body;
};

/* Our structure that contains the request's data */
struct request {
	char *type;
	char *url;
	char *vers;
	char *host;
	char *conn;
	char *user;
	char *auth;
	char *key;
	char *cenc;
	int clen;
	char *body;
};

/*
 * Funtion prototypes
 */

/* Reads data in the HTTP header format from a socket */
unsigned char *get_header(int conn);

/* Creates a HTTP header string */
unsigned char *create_req_header(struct request req, int encrypted);

/* Extracts the path from an URL */
char *URL_path(char *url, char *PATH);

/* Creates a response with header and optional body */
unsigned char *create_res_header(struct response res, int encrypted);

/* Reads a message and encodes it */
unsigned char *encode(unsigned char *message);

/* Reads an encrypted message and decodes it */
unsigned char *decode(unsigned char *cypher);

#endif

