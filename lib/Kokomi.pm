package Kokomi;
use strict;
use warnings;
our $VERSION = '0.01';
use Path::Class qw/dir file/;
use Text::Markdown;
use Text::Xslate;
use Carp qw/croak/;

sub new {
    my ( $class, %args ) = @_;
    my $self = bless {
        template_path => $args{template_path} || 'tmpl',
        input_path    => $args{input_path}    || 'data',
        output_path   => $args{output_path}   || 'html',
        md => Text::Markdown->new,
    }, $class;
    return $self;
}

sub generate {
    my $self = shift;

    croak("Source directory $self->{input_path} is not found!!") unless -d  $self->{input_path};
    croak("Output directory $self->{output_path} is not found!!") unless -d  $self->{output_path};

    if ( -d  $self->{template_path}
             && -f dir($self->{template_path})->file('footer.tt')
                 && -f dir($self->{template_path})->file('header.tt') ) {
        $self->{tx} = Text::Xslate->new(
            syntax => 'TTerse',
            header => [dir($self->{template_path})->file('header.tt')],
            footer => [dir($self->{template_path})->file('footer.tt')]
        );
    }else{
        $self->{tx} = Text::Xslate->new( syntax => 'TTerse' );
    }
    my $data = dir( $self->{input_path} );
    for my $file ( $data->children() ){
        next if $file->is_dir;
        my $content_html = $self->{md}->markdown( $file->slurp );
        my $new_path = dir( $self->{output_path} )->file($file->basename)->stringify;
        $new_path =~ s/\..+$/.html/;
        my $fh = file($new_path)->openw;
        $fh->print( $self->{tx}->render_string($content_html) );
        warn "Generate... $new_path\n";
    }
}

1;
__END__

=head1 NAME

Kokomi - Minimal HTML generator with markdown text.

=head1 SYNOPSIS

  use Kokomi;

  my $kokomi = Kokomi->new;
  $kokomi->generate;

=head1 DESCRIPTION

Kokomi is minimal command line tool to generate HTML files from markdown texts.

=head1 AUTHOR

Yusuke Wada E<lt>yusuke@kamawada.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
