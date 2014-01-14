path = require 'path'
webdriver = require 'selenium-webdriver'
chai = require 'chai'
chaiWebdriver = require '..'

driver = new webdriver.Builder()
  .withCapabilities(webdriver.Capabilities.phantomjs())
  .build()

chai.use chaiWebdriver(driver)
{expect} = chai

before ->
  url = "file://#{path.join __dirname, 'test.html'}"
  driver.get url

after (done) ->
  driver.quit().then -> done()

describe '#text', ->

  it 'verifies that an element has exact text', (done) ->
    @timeout 10000
    expect('h1').dom.to.have.text "The following text is an excerpt from Finnegan's Wake by James Joyce", done

  it 'verifies that an element does not have exact text', (done) ->
    expect('h1').dom.not.to.have.text "Wake", done

  it 'verifies that an element contains text', (done) ->
    expect('h1').dom.to.contain.text "Finnegan", done

  it 'verifies that an element does not contain text', (done) ->
    expect('h1').dom.not.to.contain.text "Bibimbap", done

describe '#visible', ->

  it 'verifies that an element is visible', (done) ->
    expect('.does-exist').dom.to.be.visible done

  it 'verifies that a non-existing element is not visible', (done) ->
    expect('.does-not-exist').dom.not.to.be.visible done

  it 'verifies that a hidden element is not visible', (done) ->
    expect('.exists-but-hidden').dom.not.to.be.visible done

describe '#count', ->

  it 'verifies that an element appears thrice', (done) ->
    expect('input').dom.to.have.count 3, done

  it 'verifies that a non-existing element has a count of 0', (done) ->
    expect('.does-not-exist').dom.to.have.count 0, done

describe '#style', ->

  it 'verifies that an element has a red background', (done) ->
    expect('.red-bg').dom.to.have.style 'background-color', 'rgba(255, 0, 0, 1)', done
  
  it 'verifies that an element does not have a red background', (done) ->
    expect('.green-text').dom.to.have.style 'background-color', 'rgba(0, 0, 0, 0)', done

describe '#value', ->

  it 'verifies that a text field has a specific value', (done) ->
    expect('.does-exist').dom.to.have.value 'People put stuff here', done

  it 'verifies that a text field does not have a specific value', (done) ->
    expect('.does-exist').dom.not.to.have.value 'Beep boop', done

describe '#disabled', ->
  it 'verifies that an input is disabled', (done) ->
    expect('.i-am-disabled').dom.to.be.disabled done

  it 'verifies that an input is not disabled', (done) ->
    expect('.does-exist').dom.not.to.be.disabled done

