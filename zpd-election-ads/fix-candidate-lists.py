import re

partyDict = {
    'Latvijas Krievu savienība': 'LKS', 
    'Jaunā konservatīvā partija': 'JKP',
    'Rīcības partija': 'Ricib', 
    'Nacionālā apvienība Visu Latvijai!-Tēvzemei un Brīvībai/LNNK': 'NA', 
    'PROGRESĪVIE': 'Progr', 
    'Latvijas centriskā partija': 'Centr', 
    'LSDSP/KDS/GKL':'LSDSP',
    'No sirds Latvijai': 'NSL', 
    'Saskaņa sociāldemokrātiskā partija': 'Sask',
    'Attīstībai/Par!': 'A-PAR',
    'Latvijas Reģionu Apvienība': 'LRA', 
    'Latviešu Nacionālisti': 'LNacio', 
    'Jaunā VIENOTĪBA': 'JV', 
    'Par Alternatīvu': 'Altern',
    'Politiskā partija KPV LV': 'KPV',
    'Zaļo un Zemnieku savienība': 'ZZS'
}

candidateTotals = 0

def parseParties(ll): 
    global candidateTotals
    p = re.compile(r'^"(\d+)\.\s+(.*)"$')
    rQuotes = re.compile(r'"')
    result = []
    items = ll.split(',')
    # count the number of empty slots
    partyNum = 0
    cc = 0
    for item in items:
        if len(item) > 0:
            if item == '\n': 
                cc=cc+1
            if partyNum > 0:
                partyCount = int((cc+1)/2);
                result.append((partyNum, partyName, partyCount))
                candidateTotals = candidateTotals + partyCount
                cc=0
        if len(item) > 0 and item != '\n': 
            if p.match(item):               
                cc = 0
                m = p.match(item)
                partyNum = int(m.group(1))
                partyName = m.group(2)
                partyName = rQuotes.sub('', partyName)                
            else:
                print('Does not match11 %s (%d)' % (item,cc))
        else: 
            cc = cc + 1
    print("partyCountTotals %s" % candidateTotals)
    return result

def parseCandidates(ll):
    p = re.compile(r'^"(\d+)\.\s+(.*)"$')
    result = []
    items = ll.split(",")
    for item in items:
        if len(item) > 0 and item != '\n': 
            if p.match(item):
                m = p.match(item)
                result.append((m.group(1),m.group(2)))
            else:
                print('Does not match22 %s' % item)
    return result

def readRecords(inFile): 
    p = re.compile(r'^"(.*)","(.*)",(.*)$')
    outRecords = []
    with open(inFile, encoding='utf-8') as f:
       content = f.readlines()
    # Line count
    count = 0
    for line in content:
        count = count + 1
        if count == 1:
            parties = parseParties(line)
        elif count == 2:
            candidates = parseCandidates(line)
        elif count == 3:
            # initialize plus and minus lists
            lPlus = [0]*candidateTotals
            lMinus = [0]*candidateTotals
        else: 
            if p.match(line):
                m = p.match(line)
                line2 = m.group(3)
            else:
                print('Does not match33 %s' % line)
            mur = line2.split(",")
            for x in range(candidateTotals):
                lPlus[x] = lPlus[x] + int(mur[2*x])
                lMinus[x] = lMinus[x] + int(mur[2*x+1])
    offset = 0
    for party in parties:
        partyNum = party[0]
        partyAbbr = partyDict[party[1]]
        partyCount = party[2]
        for x in range(partyCount):
            candNum = int(candidates[offset+x][0])
            candName = candidates[offset+x][1]
            candPlus = lPlus[offset + x]
            candMinus = lMinus[offset + x]
            outRecords.append((partyNum, partyAbbr, candNum, candName, candPlus, candMinus))
        offset = offset + partyCount
    return outRecords

def getParties(inFile):
    with open(inFile, encoding='utf-8') as f:
       content = f.readlines()
    count = 0
    for line in content:
        count = count + 1
        if count == 1:
            parties = parseParties(line)
    return parties    

def main(): 
    ROOT = 'candidates'
    apgabali = ['riga','vidzeme','latgale','kurzeme','zemgale']
#    apgabali = ['zemgale']
    for apgabals in  apgabali:
        inFile = '%s/%s' % (ROOT,'%s-plusi-svitrojumi.csv' % apgabals)
        outFile = '%s/%s' % (ROOT,'%s-data.csv' % apgabals)
        theRecords = readRecords(inFile)
        with open(outFile, encoding='utf8', mode='w+') as fOutFile:
            fOutFile.write('"ListNo","ShortName","CandNo","CandName","Pluses","Minuses"\n')
            for rr in theRecords: 
                fOutFile.write('%d,"%s",%d,"%s",%d,%d\n' % rr)
        parties = getParties(inFile)
        print('Parties are %s' % parties)

if __name__ == '__main__':
    main()


