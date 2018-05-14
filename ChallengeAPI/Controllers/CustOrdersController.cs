using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using ChallengeAPI.Models;

namespace ChallengeAPI.Controllers
{
    public class CustOrdersController : ApiController
    {
        private ChallengeDBEntities db = new ChallengeDBEntities();

        // GET: api/CustOrders
        public IQueryable<CustOrder> GetCustOrders()
        {
            return db.CustOrders;
        }

        // GET: api/CustOrders/5
        [ResponseType(typeof(CustOrder))]
        public async Task<IHttpActionResult> GetCustOrder(string id)
        {
            CustOrder custOrder = await db.CustOrders.FindAsync(id);
            if (custOrder == null)
            {
                return NotFound();
            }

            return Ok(custOrder);
        }

        // PUT: api/CustOrders/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutCustOrder(string id, CustOrder custOrder)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != custOrder.CustID)
            {
                return BadRequest();
            }

            db.Entry(custOrder).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CustOrderExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/CustOrders
        [ResponseType(typeof(CustOrder))]
        public async Task<IHttpActionResult> PostCustOrder(CustOrder custOrder)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.CustOrders.Add(custOrder);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (CustOrderExists(custOrder.CustID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = custOrder.CustID }, custOrder);
        }

        // DELETE: api/CustOrders/5
        [ResponseType(typeof(CustOrder))]
        public async Task<IHttpActionResult> DeleteCustOrder(string id)
        {
            CustOrder custOrder = await db.CustOrders.FindAsync(id);
            if (custOrder == null)
            {
                return NotFound();
            }

            db.CustOrders.Remove(custOrder);
            await db.SaveChangesAsync();

            return Ok(custOrder);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CustOrderExists(string id)
        {
            return db.CustOrders.Count(e => e.CustID == id) > 0;
        }
    }
}