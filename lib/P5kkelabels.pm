package P5kkelabels;

use 5.010;

use Moo;
with qw/
    Role::REST::Client
    Role::REST::Client::Auth::Basic
/;

use constant API_ENDPOINT => 'https://app.pakkelabels.dk/api/public/v3/';

=head1 NAME

P5kkelabels - REST API interface

=head1 SYNOPSIS

=head1 DESCRIPTION

Implements the Pakkelabels.dk API as described in
https://app.pakkelabels.dk/api/public/v3/specification

All methods return a L<Role::REST::Client::Result> object.

=head1 METHODS

=head2 products

Get available products

=cut

sub products {
    my ($self, $params) = @_;
    my $result = $self->get(API_ENDPOINT . 'products', $params);
    return $result;
}

=head2 pickup_points

Get available & nearest pickup points

=cut

sub pickup_points {
    my ($self, $params) = @_;
    my $result = $self->get(API_ENDPOINT . 'pickup_points', $params);
    return $result;
}

=head2 account_balance

Get current balance

=cut

sub account_balance {
    my $self = shift;
    my $result = $self->get(API_ENDPOINT . 'account/balance');
    return $result;
}

=head2 account_payment_request

Get payment requests

=cut

sub account_payment_requests {
    my ($self, $params) = @_;
    my $result = $self->get(API_ENDPOINT . 'account/payment_requests', $params);
    return $result;
}

=head2 shipment_monitor

Get shipment monitor statuses

=cut

sub shipment_monitor {
    my ($self, $params) = @_;
    my $result = $self->get(API_ENDPOINT . 'shipment_monitor_statuses', $params);
    return $result;
}

=head2 return_portals

Get return portals

Takes an optional id parameter

=cut

sub return_portals {
    my ($self, $params) = @_;
    my $path = 'return_portals';
    $path .= "/$params->{id}" if defined $params and exists $params->{id};
    my $result = $self->get(API_ENDPOINT . $path);
    return $result;
}

=head2 return_portal_shipments

Get Shipments for Return Portal with specific ID

Takes an id parameter

=cut

sub return_portal_shipments {
    my ($self, $params) = @_;
    die "No id provided" unless my $id = $params->{id};

    my $path = "return_portals/$id/shipments";
    my $result = $self->get(API_ENDPOINT . $path, $params);
    return $result;
}

=head2 shipments

Get shipments

Takes an optional id parameter

=cut

sub shipments {
    my ($self, $params) = @_;
    my $path = 'shipments';
    $path .= "/$params->{id}" if defined $params and exists $params->{id};

    my $result = $self->get(API_ENDPOINT . $path);
    return $result;
}

=head2 create_shipment

Create a shipment

Takes the sipment information as parameter

=cut

sub create_shipment {
    my ($self, $params) = @_;
    my $result = $self->post(API_ENDPOINT . 'shipments', $params);
    return $result;
}

=head2 shipment_labels

Get Labels for Shipment with specific ID

Takes an id parameter

=cut

sub shipment_labels {
    my ($self, $params) = @_;
    die "No id provided" unless $params->{id};

    my $path = "shipments/$params->{id}/labels";
    my $result = $self->get(API_ENDPOINT . $path);
    return $result;
}

=head2 print_queue_entries

Get print queue entries

=cut

sub print_queue_entries {
    my ($self, $params) = @_;
    my $result = $self->get(API_ENDPOINT . 'print_queue_entries');
    return $result;
}

=head2 imported_shipments

Get Imported Shipments

Takes an id parameter

=cut

sub imported_shipments {
    my ($self, $params) = @_;
    my $path = 'imported_shipments';
    $path .= "/$params->{id}" if defined $params and exists $params->{id};
    my $result = $self->get(API_ENDPOINT . $path);
    return $result;
}

=head2 create_imported_shipment

Create a shipment

Takes the sipment information as parameter

=cut

sub create_imported_shipment {
    my ($self, $params) = @_;
    my $result = $self->post(API_ENDPOINT . 'imported_shipments', $params);
    return $result;
}

=head2 update_imported_shipment

Update a shipment

Takes the sipment information as parameter

=cut

sub update_imported_shipment {
    my ($self, $params) = @_;
    my $result = $self->put(API_ENDPOINT . 'imported_shipments', $params);
    return $result;
}

=head2 delete_imported_shipment

Delete a shipment

Takes the sipment information as parameter

=cut

sub delete_imported_shipment {
    my ($self, $params) = @_;
    my $result = $self->delete(API_ENDPOINT . 'imported_shipments', $params);
    return $result;
}

=head2 labels

Get Labels for specific ID's

=cut

sub labels {
    my ($self, $params) = @_;
    my $path = "labels";
    my $result = $self->get(API_ENDPOINT . $path, $params);
    return $result;
}

1;

__END__

# ABSTRACT: API interface to pakkelabels.dk

=pod

=head1 BUGS

Please report any bugs or feature requests to bug-role-rest-client at rt.cpan.org, or through the
web interface at http://rt.cpan.org/NoAuth/ReportBug.html?Queue=P5kkelabels.
