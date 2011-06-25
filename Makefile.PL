use inc::Module::Install;
name 'Kokomi';
all_from 'lib/Kokomi.pm';

requires 'Path::Class';
requires 'Text::Markdown';
requires 'Text::Xslate';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
