import puppeteer from 'puppeteer-core';

const browser = await puppeteer.connect({
  browserWSEndpoint: 'ws://chrome:3000',
});

const page = await browser.newPage();
await page.goto('https://example.com');
console.log(await page.title());
await browser.close();
