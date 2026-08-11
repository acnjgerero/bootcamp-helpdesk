const cds = require('@sap/cds');

/**
 * ACTIVITY — Helpdesk custom logic
 * Fill in each TODO. The `after CREATE` handler at the bottom is done
 * for you as a worked example of the pattern to follow.
 */
class HelpdeskService extends cds.ApplicationService {
  init() {
    const { Tickets, Comments, Agents } = this.entities;

    // ---- Validation: new tickets need a category and a subject ----
    this.before('CREATE', 'Tickets', (req) => {
      // TODO: reject the request with req.error(400, message, target) if
      // req.data.category_ID is missing, and again if req.data.subject
      // is missing.
    });

    // ---- Structured error: block updates that try to "re-close" a closed ticket ----
    this.before('UPDATE', 'Tickets', async (req) => {
      // TODO: only if req.data.status === 'CLOSED' —
      //   1. look up the ticket's *current* status with
      //      SELECT.one.from(Tickets, req.data.ID).columns('status')
      //   2. if it's already 'CLOSED', reject the request using a
      //      structured error object: req.error({ code, message, target })
      //      instead of the plain req.error(400, message, target) form.
    });

    // ---- Custom action: closeTicket ----
    // Requires a resolution note, sets status to CLOSED, and logs the resolution as a Comment.
    this.on('closeTicket', 'Tickets', async (req) => {
      const { ID } = req.params[0];
      const { resolution } = req.data;

      if (!resolution) {
        req.error(400, 'Transaction Failed. Please add a resolution comment.');
      }

      // Look up the ticket
      const ticket = await SELECT.one
        .from(Tickets)
        .where({ ID })
        .columns('ID', 'status');

      if (!ticket) {
        req.error(404, `Ticket ${ID} not found.`);
      }

      // Prevent closing an already closed ticket
      if (ticket.status === 'CLOSED') {
        req.reject(400, {
          code: 'ALREADY_CLOSED',
          message: 'This ticket has already been closed.'
        });
      }

      // Close the ticket
      await UPDATE(Tickets)
        .set({
          status: 'CLOSED'
        })
        .where({ ID });

      // Record resolution comment
      await INSERT.into(Comments).entries({
        ticket_ID: ID,
        text: `Ticket closed: ${resolution}`
      });

      // Return updated ticket
      return await SELECT.one
        .from(Tickets)
        .where({ ID });
    });

    // ---- Custom action: reassignTicket ----
    // Moves a ticket to a different agent; validates the agent actually exists.
    this.on('reassignTicket', 'Tickets', async (req) => {
      const { ID } = req.params[0];
      const { agentID } = req.data;

      // TODO 1: reject with 400 if `agentID` is missing.
      // TODO 2: look up the agent (SELECT.one.from(Agents, agentID)); reject
      //         with 404 if it doesn't exist.
      // TODO 3: UPDATE(Tickets, ID) to set assignee_ID to the new agentID.
      // TODO 4: return the updated ticket — SELECT.one.from(Tickets, ID).
    });

    // ---- Custom function: getTicketCount ----
    // Read-only: counts tickets, optionally filtered by status.
    this.on('getTicketCount', async (req) => {
      // TODO: read req.data.status (it may be undefined). SELECT tickets from
      // Tickets, filtering by status only if one was passed, and return the
      // *count* of matching rows (not the rows themselves).
    });

    // ---- after CREATE: log new tickets (stand-in for a real notification) ----
    // (worked example — no change needed)
    this.after('CREATE', 'Tickets', (ticket) => {
      console.log(`[HelpdeskService] Ticket created: ${ticket.ticketNumber ?? ticket.ID}`);
    });

    return super.init();
  }
}

module.exports = HelpdeskService;
