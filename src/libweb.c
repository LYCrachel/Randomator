/*
 * ****************************************************************************
 *
 * PROJECT:	 Maze: A simple HTTP 1.1 web browser.
 *
 * AUTHOR:	  Brian Mayer blmayer@icloud.com
 *
 * Copyright (C) 2018	Brian Lee Mayer
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * ****************************************************************************
 */

#include <stdio.h>
#include <string.h>
#include "key.h"

unsigned char *get_header(int conn){

	int pos = 0;
	int buff_size = 1024;
	unsigned char *buffer = calloc(buff_size, 1);
	unsigned char *dest;

	/* This is a loop that will read the data coming from our connection */
	while(read(tcp_server, buffer + pos, 1) == 1){
		
		/* Increase pos by 1 to follow the buffer size */
		pos++;
		
		/* The only thing that can break our loop is a blank line */
		if(strcmp(buffer + pos - 4, "\r\n\r\n") == 0){ 
			break;
		}
		
		if(pos == buff_size){
			puts("\t\tBuffer grew.");
			buff_size += 512;
			buffer = realloc(buffer, buff_size);
		}
	}

	/* Duplicate so we can free the memory */
	dest = strdup(buffer);
	free(buffer);

	/* Duplicate to not get lost in function */
	return strdup(dest);
}

unsigned char *create_header(struct request req, int encrypted){
    
    /* URL request line, includes version, spaces and \r\n */
    int header_size = strlen(req.type) + strlen(req.url) + 12;

	/* Host, user agent and conn lines */
	header_size += strlen(req.host) + strlen(req.user) + strlen(req.conn) + 6;
	
    /* Accept line */
	header_size += strlen(req.cenc) + 2;
	
	/* And optional lines */
	if(req.auth != NULL){
		header_size += strlen(req.auth) + 17;
	}
	if(req.key != NULL){
		header_size += strlen(req.key) + 7;
	}
	
    /* The header string, +1 for the end zero and +2 for blank line */
    unsigned char header[header_size + 46];
	
	/* Copy all parameters to it */
    sprintf(header, "%s %s HTTP/%s\r\n", req.type, req.url, req.vers);
    sprintf(header + strlen(header), "Host: %s\r\n", req.host);
	sprintf(header + strlen(header), "User-Agent: %s\r\n", req.user);
	sprintf(header + strlen(header), "Connection: %s\r\n", req.conn);
	sprintf(header + strlen(header), "Accept: %s\r\n", req.cenc);
	if(req.auth != NULL){
		sprintf(header + strlen(header), "Authorization: %s\r\n", req.auth);
	}
	if(req.key != NULL){
		sprintf(header + strlen(header), "Key: %s\r\n", req.key);
	}
	
    if(encrypted){
        strcpy(header, encode(header));
    }

	/* Add blank line */
	sprintf(header + strlen(header), "\r\n");
	
    return strdup(header);
}

