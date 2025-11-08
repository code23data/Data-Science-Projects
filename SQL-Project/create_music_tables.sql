-- Employee Table
CREATE TABLE employee (
    employee_id INTEGER PRIMARY KEY,
    last_name TEXT,
    first_name TEXT,
    title TEXT,
    reports_to INTEGER REFERENCES employee(employee_id),
    levels TEXT,
    birthdate DATE,
    hire_date DATE,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    postal_code TEXT,
    phone TEXT,
    fax TEXT,
    email TEXT
);

-- Customer table
CREATE TABLE customer (
    customer_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    company TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    country TEXT,
    postal_code TEXT,
    phone TEXT,
    fax TEXT,
    email TEXT,
    support_rep_id INTEGER REFERENCES employee(employee_id)
);

-- Invoice table
CREATE TABLE invoice (
    invoice_id INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customer(customer_id),
    invoice_date DATE,
    billing_address TEXT,
    billing_city TEXT,
    billing_state TEXT,
    billing_country TEXT,
    billing_postal_code TEXT,
    total FLOAT
);

-- Artist table
CREATE TABLE artist (
    artist_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Album table
CREATE TABLE album (
    album_id INTEGER PRIMARY KEY,
    title TEXT,
    artist_id INTEGER REFERENCES artist(artist_id)
);

-- Media Type Table
CREATE TABLE media_type (
    media_type_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Genre Table
CREATE TABLE genre (
    genre_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Playlist Table
CREATE TABLE playlist (
    playlist_id INTEGER PRIMARY KEY,
    name TEXT
);

-- Track table
CREATE TABLE track (
    track_id INTEGER PRIMARY KEY,
    name TEXT,
    album_id INTEGER REFERENCES album(album_id),
    media_type_id INTEGER REFERENCES media_type(media_type_id),
    genre_id INTEGER REFERENCES genre(genre_id),
    composer TEXT,
    milliseconds INTEGER,
    bytes INTEGER,
    unit_price FLOAT
);

-- Invoice Line
CREATE TABLE invoice_line (
    invoice_line_id INTEGER PRIMARY KEY,
    invoice_id INTEGER REFERENCES invoice(invoice_id),
    track_id INTEGER REFERENCES track(track_id),
    unit_price FLOAT,
    quantity INTEGER
);

-- Playlist_track (junction table)
CREATE TABLE playlist_track (
    playlist_id INTEGER NOT NULL REFERENCES playlist(playlist_id) ON DELETE CASCADE,
    track_id INTEGER NOT NULL REFERENCES track(track_id) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, track_id)
);