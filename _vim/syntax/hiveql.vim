"=============================================================================
" FILE: syntax/hiveql.vim
" AUTHOR: Yuku Takahashi <yuku.takahashi@gmail.com>
" Last Modified: 11 Jul 2011
"=============================================================================

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syn case ignore

" HiveQL keywords
syn keyword hqlKeyword     add after alter archive as buckets by change clustered
syn keyword hqlKeyword     collection column columns comment create deferred delimited
syn keyword hqlKeyword     describe dot drop exists extended external fields first 
syn keyword hqlKeyword     format formatted from function idxproperties if index 
syn keyword hqlKeyword     indexes into items keys like lines location map not on
syn keyword hqlKeyword     partitioned rebuild rename replace row select serde
syn keyword hqlKeyword     serdeproperties show sorted stored struct table
syn keyword hqlKeyword     tblproperties terminated to touch unarchive view with

" HiveQL file format
syn keyword fileFormat    sequencefile textfile rcfile inputformat

" HiveQL primitive type
syn keyword primitiveType tinyint smallint int bigint boolean float double string

" HiveQL function
syn keyword hqlFunction    abs acos and array array_contains ascii asin atan avg bin
syn keyword hqlFunction    case ceil ceiling coalesce collect_set concat concat_ws
syn keyword hqlFunction    context_ngrams conv corr cos count covar_pop covar_samp
syn keyword hqlFunction    create_union date_add date_sub datediff day dayofmonth
syn keyword hqlFunction    degrees div e elt exp explode field find_in_set floor
syn keyword hqlFunction    from_unixtime get_json_object hash hex histogram_numeric
syn keyword hqlFunction    hour if in index instr isnotnull isnull json_tuple lcase
syn keyword hqlFunction    length like ln locate log log10 log2 lower lpad ltrim map
syn keyword hqlFunction    max min minute month negative ngrams not or parse_url
syn keyword hqlFunction    parse_url_tuple percentile percentile_approx pi pmod
syn keyword hqlFunction    positive pow power radians rand reflect regexp
syn keyword hqlFunction    regexp_extract regexp_replace repeat reverse rlike round
syn keyword hqlFunction    rpad rtrim second sentences sign sin size space split sqrt
syn keyword hqlFunction    std stddev stddev_pop stddev_samp str_to_map substr
syn keyword hqlFunction    substring sum tan to_date trim ucase unhex unix_timestamp
syn keyword hqlFunction    upper var_pop var_samp variance weekofyear when xpath
syn keyword hqlFunction    xpath_boolean xpath_double xpath_float xpath_int xpath_long
syn keyword hqlFunction    xpath_number xpath_short xpath_string year

" Strings and characters
syn region hqlString       start=+"+ end=+"+ contains=@Spell
syn region hqlString       start=+'+ end=+'+ contains=@Spell

" Numbers
syn match hqlNumber		"-\=\<\d*\.\=[0-9_]\>"

if version >= 508 || !exists("did_hiveql_syn_inits")
    if version < 508
        let did_hiveql_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi link <args>
    endif

    HiLink hqlNumber     Number
    HiLink hqlString     String
    HiLink hqlKeyword    Keyword
    HiLink fileFormat    Type
    HiLink primitiveType Type
    HiLink hqlFunction   Function

    delcommand HiLink
endif

let b:current_syntax = "hiveql"

" vim:sw=4:
