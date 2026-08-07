namespace bootcamp.helpdesk;

using { managed, cuid } from '@sap/cds/common';

// ---- Custom Types ----
type Email : String(111);

type TicketStatus : String enum {
  open       = 'OPEN';
  inProgress = 'IN_PROGRESS';
  resolved   = 'RESOLVED';
  closed     = 'CLOSED';
}

type Priority : String enum {
  low    = 'LOW';
  medium = 'MEDIUM';
  high   = 'HIGH';
  urgent = 'URGENT';
}

// ---- Entities ----
entity Categories : cuid {
  name : String(50);
}

entity Agents : cuid {
  name  : String(111);
  email : Email;
}

entity Tickets : cuid, managed {
  ticketNumber : String(20);
  subject      : String(140);
  description  : String(1000);
  status       : TicketStatus default 'OPEN';
  priority     : Priority default 'MEDIUM';
  category     : Association to Categories;
  assignee     : Association to Agents;
  comments     : Composition of many Comments on comments.ticket = $self;
}

entity Comments : cuid, managed {
  ticket : Association to Tickets;
  text   : String(1000);
}
