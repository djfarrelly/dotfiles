// Make the prompt useful
// Assuming all hosts running locally are <machine>.local
const isLocal = !!db.serverStatus().host.match(/.local/)
prompt = () => `${isLocal ? '💻' : '☁️ '} ${db.getMongo().getReadPrefMode()} / ${db.getName()} () → `
