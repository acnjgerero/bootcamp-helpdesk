using bootcamp.helpdesk as helpdesk from '../db/schema';

service HelpdeskService {
  entity Categories as projection on helpdesk.Categories;
  entity Agents     as projection on helpdesk.Agents;
  @readonly
  entity Comments   as projection on helpdesk.Comments;
  entity Statuses as projection on helpdesk.Statuses;
  entity Priorities as projection on helpdesk.Priorities;

  @odata.draft.enabled
  entity Tickets    as projection on helpdesk.Tickets {
    *,
    case
      when status = 'CLOSED' then 1 // Red
      when status = 'RESOLVED' then 3 // Green
      when status = 'IN_PROGRESS' then 5 // Blue
      else 0 // Neutral (OPEN)
      end as statusCriticality : Integer,
    
    case
      when priority = 'LOW' then 3
      when priority = 'MEDIUM' then 2
      when priority = 'HIGH' then 1
      when priority = 'URGENT' then 1
      else 0
      end as priorityCriticality : Integer
  } 
  actions {
    // Side-effecting: closes the ticket and logs a resolution comment.
    action closeTicket(resolution: String) returns Tickets;
    // Side-effecting: moves the ticket to a different agent.
    action reassignTicket(agentID: UUID) returns Tickets;
  };

  annotate Tickets with actions {
    closeTicket @(
      Common.SideEffects : {
          $Type : 'Common.SideEffectsType',
          TargetEntities : [
              comments
          ],
          TargetProperties : [
              'status',
              'statusCriticality'
          ],
      }
    )
  };
  

  // Read-only: counts tickets, optionally narrowed to one status.
  function getTicketCount(status: helpdesk.TicketStatus) returns Integer;
}
