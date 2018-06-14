'use strict';

module.exports.handler = (event, context, callback) => {
    const response = {
        statusCode: 200,
        headers: {
            'Access-Control-Allow-Origin': '*', // Required for CORS support to work
        },
        body: JSON.stringify({
            message: 'Hello Awskrug',
            input: event,
        }),
    };
    callback(null, response);
};
