SET ANSI_NULLS, QUOTED_IDENTIFIER ON;
UPDATE sites SET url='http://inosa.local' WHERE 1 = 1;
UPDATE settings SET values_data = '["public\/inosa_logo.png"]' WHERE id = 'site_logo';
UPDATE users SET password_hash = '$2y$10$T2O40hKJlyX415wLc.rN3OsUBjWAfEo.D8wQYBJnhSECtxR1qb.72' WHERE 1=1;
UPDATE users SET locale_code = 'en-GB' WHERE 1 = 1;

