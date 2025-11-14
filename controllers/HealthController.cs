using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace StudentAPI.controllers
{
    [Route("/api/v1")]
    [ApiController]
    public class HealthController: ControllerBase
    {
        [HttpGet("health")]
        public IActionResult GetHealth()
        {
            return Ok("API is healthy");
        }
    }
}