package Encode::Arabic::Franco;
use parent qw(Encode::Encoding);
use strict;
use warnings;
use utf8;

__PACKAGE__->Define(qw(Franco-Arabic Arabizy));

# ABSTRACT: Does transliteration from chat Arabic

sub decode($$;$){
    my ($obj, $str, $chk) = @_;

    $str =~ s/\b[ae]l/ال/g;
    $str =~ s/(2|\b)e/إ/g;
    $str =~ s/(2|\b)[ou]/أُ/g;
    $str =~ s/2|\ba/أ/g;

    $str =~ s/3'/غ/g;
    $str =~ s/7'/خ/g;

    $str =~ s/kh/خ/g;
    $str =~ s/gh/غ/g;
    $str =~ s/sh/ش/g;

    $str =~ tr
        { 3 4 5 6 7 8 9 } 
        { ع ش خ ط ح غ ق };

    $str =~ tr
        { a b c d e f g h i j k l m n o p q r s t u v w x y z }
        { ا ب _ د ي ف ج ه ي ج ك ل م ن و پ ق ر س ت و ڤ و _ ي ز };
    
    $str =~ tr
        { , ; ? }
        { ، ؛ ؟ };

    $_[1] = '' if $chk;
    return $str;
}
1;

__END__


=head1 NAME

Encode::Arabic::Franco - Turns Franco-/Chat-Arabic into actual Arabic letters


=head1 SYNOPSIS

    use Encode;
    use Encode::Arabic::Franco;

    while ($line = <>) {
        print encode 'franco-arabic', $line;   # 'Franco-Arabic' alias 'Arabizy'
    }

    # oneliner
    $ perl -MEncode -MEncode::Arabic::Franco -pe '$_ = encode "arabizy", $_'

=head1 DESCRIPTION

Franco-Arabic, aka Chat Arabic, Arabizy, is a transliteration of Arabic, commonly used on the internet. It restricts itself to the ASCII charset and substitutes numbers for the Arabic characters which have no equivalent in Latin.

Franco-Arabic is not standardized. This module is far from complete.


=head2 IMPLEMENTATION

Currently nothing more than a chain of C<tr>icks à la:

    $str =~ s/3'/غ/g;
    $str =~ s/7'/خ/g;

=head1 Git repo

L<http://github.com/a3f/Encode-Arabic-Franco>

=head1 SEE ALSO

L<Encode|Encode>, L<Encode::Encoding|Encode::Encoding>, L<Encode::Arabic|Encode::Arabic>, 

Wikipedia article on Franco Arabic  L<https://en.wikipedia.org/wiki/Arabic_chat_alphabet>

Buckwalter Arabic Morphological Analyzer
    L<http://www.ldc.upenn.edu/Catalog/CatalogEntry.jsp?catalogId=LDC2002L49>
(Might be employed in future)


=head1 AUTHOR

Ahmad Fatoum C<< <athreef@cpan.org> >>, L<http://a3f.at>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 Ahmad Fatoum

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.


=cut
