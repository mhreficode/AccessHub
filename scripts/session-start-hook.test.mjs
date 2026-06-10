import assert from 'node:assert/strict';
import test from 'node:test';
import { readFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const sessionStartPath = path.resolve(__dirname, '../.github/hooks/session-start.json');

async function readSessionStartConfig() {
  const raw = await readFile(sessionStartPath, 'utf8');
  return JSON.parse(raw);
}

test('sessionStart hook validates workshop state before priming session context', async () => {
  const config = await readSessionStartConfig();

  assert.equal(config.version, 1);
  assert.ok(Array.isArray(config.hooks?.sessionStart));
  assert.equal(config.hooks.sessionStart.length, 2);

  const [validationStep, contextStep] = config.hooks.sessionStart;

  assert.equal(validationStep.type, 'command');
  assert.equal(validationStep.bash, './scripts/validate-workshop-state.sh');
  assert.equal(validationStep.powershell, './scripts/validate-workshop-state.ps1');
  assert.equal(validationStep.cwd, '.');
  assert.equal(validationStep.timeoutSec, 20);

  assert.equal(contextStep.type, 'command');
  assert.match(contextStep.bash, /additionalContext/);
  assert.match(contextStep.bash, /Session variable: x=5/);
  assert.match(contextStep.bash, /explicitly overridden by the user/);
  assert.equal(contextStep.cwd, '.');
  assert.equal(contextStep.timeoutSec, 5);
});