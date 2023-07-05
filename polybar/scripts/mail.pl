#!/usr/bin/perl
use strict;
use warnings;

use Mail::IMAPClient;
use IO::Socket;
use IO::Socket::SSL;

my $usage = "$0 <mail> <passwd>\n";

my $mail_hostname = "imap.gmail.com";
my $mail_username = shift or die $usage;
my $mail_password = shift or die $usage;

my $socket = IO::Socket::SSL->new
    (PeerAddr => $mail_hostname,
     PeerPort => 993,
     Timeout => 5) or die $@;

my $client = Mail::IMAPClient->new
    (Socket => $socket,
     User => $mail_username,
     Password => $mail_password,
     Timeout => 5) or die $@;

die $@ unless ($client->IsAuthenticated ());
print $client->message_count ("INBOX");
