# Use official Node.js Alpine image
FROM node:22.15.0-alpine3.21

# Set working directory
WORKDIR /app

# Set environment to production
ENV NODE_ENV=production
ENV PORT=8080
ENV HOSTNAME=0.0.0.0

# Create non-root user
RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nextjs

# Copy only necessary files from standalone build
COPY --chown=nextjs:nodejs .next/standalone ./
COPY --chown=nextjs:nodejs .next/static .next/static/
COPY --chown=nextjs:nodejs public/ public/  

# Use non-root user
USER nextjs

# Expose the port
EXPOSE 8080

# Start the Next.js app
CMD ["node", "server.js"]
