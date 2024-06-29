import puppeteer from 'puppeteer-extra';
import StealthPlugin from 'puppeteer-extra-plugin-stealth';
puppeteer.use(StealthPlugin());

const browser = await puppeteer.launch({
  headless: 'new',
  args: [
    '--no-sandbox',
    '--disable-setuid-sandbox',
  ],
  executablePath: puppeteer.executablePath(),
});

const page = await browser.newPage();
await page.goto('https://bot.sannysoft.com/', {
  waitUntil: [
    'load',
    'networkidle0'
  ],
});

const headless_chrome_detection_tests = await page.evaluate(() => {
  const rows = Array.from(document.querySelectorAll('table:first-of-type tr:not(:first-of-type)'));
  const entries = rows.map(row => {
    const col = row.querySelector('td:last-of-type');
    return [col.id, col.classList.contains('passed')];
  })
  return Object.fromEntries(entries);
});

console.log(headless_chrome_detection_tests);

await page.close();
await browser.close();

