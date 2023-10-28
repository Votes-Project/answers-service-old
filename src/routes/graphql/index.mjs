
import fastifyPostGraphile from "@autotelic/fastify-postgraphile"

const DATABASE_URL = process.env.DATABASE_PRIVATE_URL || process.env.DATABASE_URL
console.log("DATABASE_URL: ", DATABASE_URL)


const graphql = async (fastify, opts) => {
  fastify.register(fastifyPostGraphile, { database: DATABASE_URL })

  fastify.get('/', (req, reply) => {
    reply.type('application/json')
    reply.send({ foo: 'bar' })
  })

  fastify.post('/', (req, reply) => {
    reply.type('application/json')
    reply.send({ hello: 'world' })
  })
}

export default graphql;