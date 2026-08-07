using bootcamp.helpdesk as helpdesk from '../db/schema';

service HelpdeskService {
  entity Categories as projection on helpdesk.Categories;
  entity Agents     as projection on helpdesk.Agents;
  entity Comments   as projection on helpdesk.Comments;

  entity Tickets    as projection on helpdesk.Tickets actions {
    // Side-effecting: closes the ticket and logs a resolution comment.
    action closeTicket(resolution: String) returns Tickets;
    // Side-effecting: moves the ticket to a different agent.
    action reassignTicket(agentID: UUID) returns Tickets;
  };

  // Read-only: counts tickets, optionally narrowed to one status.
  function getTicketCount(status: helpdesk.TicketStatus) returns Integer;
}
