<?php

return [

    'paths' => ['api/*'],
    'allowed_methods' => ['GET','POST'],
    'allowed_origins' => [
        'http://localhost:5173',
        'https://undercater.com',
        'https://admin.undercater.com',
        'https://undercater.client.jazertechsolution.com',
        'https://undercater.admin.jazertechsolution.com',
        'https://undercater.api.jazertechsolution.com',
        'https://kitchencraft.online',
        'https://admin.kitchencraft.online'
    ],
    'allowed_origins_patterns' => [],
    'allowed_headers' => [':authority:', ':method:', ':path:', ':scheme:','*'],
    'exposed_headers' => [],
    'max_age' => 0,
    'supports_credentials' => false
];
