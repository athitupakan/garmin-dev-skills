// Batch-regenerate the auto-converted doc mirror from the installed Connect IQ SDK.
// Run from anywhere:  node _refresh/convert.js
// Override the SDK with:  SDK=/path/to/sdk/doc node _refresh/convert.js
'use strict';
const fs = require('fs');
const path = require('path');
const { convert } = require('./htmlmd.js');

// connect-iq-docs/ is the parent of this _refresh/ folder.
const REF = path.resolve(__dirname, '..');
const TODAY = new Date().toISOString().slice(0, 10);
const SDKVER = '9.1.0';

function findSdkDoc() {
  if (process.env.SDK) return process.env.SDK;
  // Windows default; adjust for macOS/Linux if running there.
  const roots = [
    path.join(process.env.APPDATA || '', 'Garmin', 'ConnectIQ', 'Sdks'),
    path.join(process.env.HOME || '', 'Library', 'Application Support', 'Garmin', 'ConnectIQ', 'Sdks'),
    path.join(process.env.HOME || '', '.Garmin', 'ConnectIQ', 'Sdks'),
  ];
  for (const root of roots) {
    if (!root || !fs.existsSync(root)) continue;
    const dirs = fs.readdirSync(root).filter(d => /^connectiq-sdk-/.test(d)).sort();
    if (dirs.length) return path.join(root, dirs[dirs.length - 1], 'doc');
  }
  throw new Error('No Connect IQ SDK found. Set SDK=<path-to-sdk>/doc and retry.');
}

const SDK = findSdkDoc();
const API = 'https://developer.garmin.com/connect-iq/api-docs/';
const RG = 'https://developer.garmin.com/connect-iq/reference-guides/';
const BASICS = 'https://developer.garmin.com/connect-iq/connect-iq-basics/';
const CORET = 'https://developer.garmin.com/connect-iq/core-topics/';
const UXG = 'https://developer.garmin.com/connect-iq/user-experience-guidelines/';
const PERS = 'https://developer.garmin.com/connect-iq/personality-library/';
const DEVREF = 'https://developer.garmin.com/connect-iq/device-reference/';

// "Manifest_and_Permissions.html" -> "manifest-and-permissions"
const kebab = s => s.replace(/\.html$/, '').replace(/_/g, '-').toLowerCase();

// Enumerate every article page in an SDK doc/docs/<Section>/ folder (minus the
// landing Overview page, which we hand-write as index.md) into target entries.
function bucket(srcDir, outDir, urlBase) {
  return fs.readdirSync(path.join(SDK, srcDir))
    .filter(f => /\.html$/.test(f) && f !== 'Overview.html')
    .map(f => ({ src: srcDir + '/' + f, out: outDir + '/' + kebab(f) + '.md', url: urlBase + kebab(f) + '/' }));
}

// src = path under the SDK doc/ root. out = path under connect-iq-docs/.
// extra = submodule pages appended (their classes carry the real fields/methods).
const targets = [
  { src: 'docs/Reference_Guides/Jungle_Reference.html',            out: 'reference/reference-guides/jungle-reference.md',      url: RG + 'jungle-reference/' },
  { src: 'docs/Reference_Guides/Monkey_C_Reference.html',          out: 'reference/reference-guides/monkey-c-reference.md',    url: RG + 'monkey-c-reference/' },
  { src: 'docs/Reference_Guides/Monkey_Motion_Reference.html',     out: 'reference/reference-guides/monkey-motion-reference.md', url: RG + 'monkey-motion-reference/' },
  { src: 'docs/Reference_Guides/Monkey_Graph_Reference.html',      out: 'reference/reference-guides/monkey-graph-reference.md',  url: RG + 'monkey-graph-reference/' },
  { src: 'docs/Reference_Guides/Monkey_C_Command_Line_Setup.html', out: 'reference/reference-guides/command-line-setup.md',    url: RG + 'monkey-c-command-line-setup/' },
  { src: 'docs/Reference_Guides/Visual_Studio_Code_Extension.html', out: 'reference/reference-guides/vscode-extension.md',     url: RG + 'visual-studio-code-extension/' },

  { src: 'Toybox/Weather.html',             out: 'reference/api/weather.md',             url: API + 'Toybox/Weather.html',
    extra: ['Toybox/Weather/CurrentConditions.html', 'Toybox/Weather/HourlyForecast.html', 'Toybox/Weather/DailyForecast.html'] },
  { src: 'Toybox/Position.html',            out: 'reference/api/position.md',            url: API + 'Toybox/Position.html',
    extra: ['Toybox/Position/Location.html', 'Toybox/Position/Info.html'] },
  { src: 'Toybox/Application/Storage.html', out: 'reference/api/application-storage.md',  url: API + 'Toybox/Application/Storage.html' },
  { src: 'Toybox/WatchUi.html',             out: 'reference/api/watchui.md',             url: API + 'Toybox/WatchUi.html' },
  { src: 'Toybox/Lang.html',                out: 'reference/api/lang.md',                url: API + 'Toybox/Lang.html' },
  { src: 'Toybox/Math.html',                out: 'reference/api/math.md',                url: API + 'Toybox/Math.html' },
  { src: 'Toybox/Attention.html',           out: 'reference/api/attention.md',           url: API + 'Toybox/Attention.html' },
  { src: 'Toybox/Complications.html',       out: 'reference/api/complications.md',        url: API + 'Toybox/Complications.html' },
  { src: 'Toybox/FitContributor.html',      out: 'reference/api/fit-contributor.md',      url: API + 'Toybox/FitContributor.html' },
  { src: 'Toybox/Communications.html',      out: 'reference/api/communications.md',        url: API + 'Toybox/Communications.html' },
  { src: 'Toybox/Timer.html',               out: 'reference/api/timer.md',               url: API + 'Toybox/Timer.html', extra: ['Toybox/Timer/Timer.html'] },
  { src: 'Toybox/Time.html',                out: 'reference/api/time.md',                url: API + 'Toybox/Time.html' },
];

// ---- portal bucket: auto-enumerated article sections ----
targets.push(...bucket('docs/Connect_IQ_Basics', 'portal/connect-iq-basics', BASICS));
targets.push(...bucket('docs/Core_Topics', 'portal/core-topics', CORET));
targets.push(...bucket('docs/User_Experience_Guidelines', 'portal/ux-guidelines', UXG));
targets.push(...bucket('docs/Personality_Library', 'portal/personality-library', PERS));
targets.push(...bucket('docs/Device_Reference', 'portal/device-reference', DEVREF));

console.log('SDK:', SDK);
let n = 0;
for (const t of targets) {
  const srcPath = path.join(SDK, t.src);
  if (!fs.existsSync(srcPath)) { console.log('MISS', t.src); continue; }
  let md = convert(fs.readFileSync(srcPath, 'utf8'));
  for (const ex of (t.extra || [])) {
    const exPath = path.join(SDK, ex);
    if (fs.existsSync(exPath)) md += '\n\n---\n\n' + convert(fs.readFileSync(exPath, 'utf8'));
    else console.log('  MISS extra', ex);
  }
  const fm = [
    '---',
    `source: ${t.url}`,
    `sdk: ${SDKVER}`,
    `fetched: ${TODAY}`,
    `generated: auto-converted from SDK doc/${t.src} via _refresh/htmlmd.js — faithful mirror, not hand-curated`,
    '---', '', '',
  ].join('\n');
  const outPath = path.join(REF, t.out);
  fs.mkdirSync(path.dirname(outPath), { recursive: true });
  fs.writeFileSync(outPath, fm + md);
  console.log('wrote', t.out);
  n++;
}
console.log(`\n${n} files regenerated under ${REF}`);
