import { createClient } from '@supabase/supabase-js';
const url = import.meta.env.PUBLIC_SUPABASE_URL?.trim();
const key = import.meta.env.PUBLIC_SUPABASE_ANON_KEY?.trim();
if (!!url !== !!key) throw new Error('Falta PUBLIC_SUPABASE_URL o PUBLIC_SUPABASE_ANON_KEY.');
export const supabase = url && key ? createClient(url, key) : null;
