//+------------------------------------------------------------------+
//|                                                      funcoes.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
/*Index(['Hora', 'dif', 'retracao +',
       'retracao -', 'RSI', 'M22M44', 'M22M66', 'M66M44', 'ADX', 'ATR',
       'Momentum', 'Force', 'OBV', 'VOL', 'CCI', 'Bears', 'Bulls', 'Stock1',
       'Stock2', 'Wilians', 'Std', 'Acumulacao', 'MFI', 'band1', 'band2',
       'band3'],
       colunas = ['Hora', 'dif', 'retracao +','retracao -', 'RSI', 'M22M44', 'M22M66', 'M66M44', 'ADX', 'ATR',
           'Momentum', 'Force', 'OBV', 'VOL', 'CCI', 'Bears', 'Bulls', 'Stock1','Stock2', 'Wilians', 'Std',
           'Acumulacao', 'MFI', 'band1', 'band2','band3']
      dtype='object')*/
/* Configuracoes da media movel */
sinput string s0; //---------------------------
input int mm_um_periodo                    = 22;            // Periodo Média Rápida
input int mm_cinco_periodo                 = 44;            // Periodo Media lenta
input int mm_quinze_periodo                = 66;            // Periodo Media lenta
input ENUM_TIMEFRAMES mm_tempo_grafico     = PERIOD_CURRENT;// Tempo Gráfico
input ENUM_MA_METHOD  mm_metodo            = MODE_EMA;      // Método 
input ENUM_APPLIED_PRICE  mm_preco         = PRICE_CLOSE;   // Preço Aplicado
//--- Médias Móveis
int mm_um_Handle;
double mm_um_Buffer[]; // Buffer para armazenamento dos dados das médias
int mm_cinco_Handle;
double mm_cinco_Buffer[]; // Buffer para armazenamento dos dados das médias
int mm_quinze_Handle;
double mm_quinze_Buffer[]; // Buffer para armazenamento dos dados das médias
//--- RSI
int RSI ;
double RSI_Buffer[];
//---ADX
int ADX;
double ADX_B[];
//---ATR
int ATR;
double ATR_B[];
//---MOMENTUM
int MMO;
double MMO_B[];
//---FORCE
int FORCE;
double FORCE_B[];
//---OBV
int OBV;
double OBV_B[];
//---VOL
int VOL;
double VOL_B[];
//---CCI
int CCI;
double CCI_B[];
//---BEARS
int BEARS;
double BEARS_B[];
//---BULLS
int BULLS;
double BULLS_B[];
//---STOCK1
int STOCK;
double STOCK1_B[];
double STOCK2_B[];
//---WILLIANS
int WILLIANS;
double WILLIANS_B[];
//--- STD
int STD;
double STD_B[];
//--- ACUMULAÇÂO
int AC;
double AC_B[];
//--- MFI
int MFI;
double MFI_B[];
//--- BBANDS
int BBANDS;
double BBANDS1_B[];
double BBANDS2_B[];
double BBANDS3_B[];



//--- Dados dos gráficos
MqlDateTime horaAtual;       // Variavel para aramazenar tempo
MqlTick tick;                // variável para armazenar ticks 
MqlRates velas[];            // Variável para armazenar velas

/* Configuracoes para acesso as variaveis */
void inicializacao()
{
   RSI = iRSI(_Symbol,mm_tempo_grafico,14,mm_preco);
   mm_um_Handle = iMA(_Symbol,mm_tempo_grafico,mm_um_periodo,0,mm_metodo,mm_preco);
   mm_cinco_Handle = iMA(_Symbol,mm_tempo_grafico,mm_cinco_periodo,0,mm_metodo,mm_preco);
   mm_quinze_Handle = iMA(_Symbol,mm_tempo_grafico,mm_quinze_periodo,0,mm_metodo,mm_preco);
   ADX = iADX(_Symbol,PERIOD_CURRENT,14);
   ATR = iATR(_Symbol,PERIOD_CURRENT,14);
   MMO = iMomentum(_Symbol,PERIOD_CURRENT,14,mm_preco);
   FORCE = iForce(_Symbol,PERIOD_CURRENT,13,MODE_SMA,VOLUME_TICK);
   OBV = iOBV(_Symbol,PERIOD_CURRENT,VOLUME_TICK);
   VOL = iCustom(_Symbol,PERIOD_CURRENT,"Examples\\Volumes",VOLUME_TICK);
   CCI = iCCI(_Symbol,PERIOD_CURRENT,15,PRICE_CLOSE);
   BEARS = iBearsPower(_Symbol,PERIOD_CURRENT,13);
   BULLS = iBullsPower(_Symbol,PERIOD_CURRENT,13);
   STOCK = iStochastic(_Symbol,PERIOD_CURRENT,5,3,3,MODE_SMA,STO_LOWHIGH);
   WILLIANS = iWPR(_Symbol,PERIOD_CURRENT,14);
   STD = iStdDev(_Symbol,PERIOD_CURRENT,20,0,MODE_SMA,mm_preco);
   AC = iAD(_Symbol,PERIOD_CURRENT,VOLUME_REAL);
   MFI = iMFI(_Symbol,PERIOD_CURRENT,14,VOLUME_TICK);
   BBANDS = iBands(_Symbol,PERIOD_CURRENT,20,0,2,mm_preco);
   
}
string indicadores()
{
   //---Configuracoes---     
   HistorySelect(0,TimeCurrent());
   TimeToStruct(TimeCurrent(),horaAtual);
   SymbolInfoTick(_Symbol,tick);
   //----------------------
   CopyRates(_Symbol,_Period,0,4,velas);
   CopyBuffer(RSI,0,0,4,RSI_Buffer);
   CopyBuffer(mm_um_Handle,0,0,4,mm_um_Buffer);
   CopyBuffer(mm_cinco_Handle,0,0,4,mm_cinco_Buffer);
   CopyBuffer(mm_quinze_Handle,0,0,4,mm_quinze_Buffer);
   CopyBuffer(ADX,0,0,4,ADX_B);
   CopyBuffer(ATR,0,0,4,ATR_B);
   CopyBuffer(MMO,0,0,4,MMO_B);
   CopyBuffer(FORCE,0,0,4,FORCE_B);
   CopyBuffer(OBV,0,0,4,OBV_B);
   CopyBuffer(VOL,0,0,4,VOL_B);
   CopyBuffer(CCI,0,0,4,CCI_B);
   CopyBuffer(BEARS,0,0,4,BEARS_B);
   CopyBuffer(BULLS,0,0,4,BULLS_B);
   CopyBuffer(STOCK,0,0,4,STOCK1_B);
   CopyBuffer(STOCK,1,0,4,STOCK2_B);
   CopyBuffer(WILLIANS,0,0,4,WILLIANS_B);
   CopyBuffer(STD,0,0,4,STD_B);
   CopyBuffer(AC,0,0,4,AC_B);
   CopyBuffer(MFI,0,0,4,MFI_B);
   CopyBuffer(BBANDS,0,0,4,BBANDS1_B);
   CopyBuffer(BBANDS,1,0,4,BBANDS2_B);
   CopyBuffer(BBANDS,2,0,4,BBANDS3_B);
   
   //----------------------------
   ArraySetAsSeries(velas,true);
   ArraySetAsSeries(RSI_Buffer,true);
   ArraySetAsSeries(mm_um_Buffer,true);
   ArraySetAsSeries(mm_cinco_Buffer,true);
   ArraySetAsSeries(mm_quinze_Buffer,true);
   ArraySetAsSeries(ADX_B,true);
   ArraySetAsSeries(ATR_B,true);
   ArraySetAsSeries(MMO_B,true);
   ArraySetAsSeries(FORCE_B,true);
   ArraySetAsSeries(OBV_B,true);
   ArraySetAsSeries(VOL_B,true);
   ArraySetAsSeries(CCI_B,true);
   ArraySetAsSeries(BEARS_B,true);
   ArraySetAsSeries(BULLS_B,true);
   ArraySetAsSeries(STOCK1_B,true);
   ArraySetAsSeries(STOCK2_B,true);
   ArraySetAsSeries(WILLIANS_B,true);
   ArraySetAsSeries(STD_B,true);
   ArraySetAsSeries(AC_B,true);
   ArraySetAsSeries(MFI_B,true);
   ArraySetAsSeries(BBANDS1_B,true);
   ArraySetAsSeries(BBANDS2_B,true);
   ArraySetAsSeries(BBANDS3_B,true);
   
   //formacao dos dados
   string data = DoubleToString(((horaAtual.hour*100)+( horaAtual.min-1)),0);//1
   data  += "," + DoubleToString((velas[1].close - velas[1].open),0);//2
   if(velas[1].close >= velas[1].open) //alta
    {
      // se for alta, retracao positiva
      data += "," + DoubleToString((velas[1].high - velas[1].close),0);//3 
      // se for alta, retracao negativa
      data += "," + DoubleToString((velas[1].open - velas[1].low),0);//4
    }
   else//baixa
    {
      // se for alta, retracao negativa
      data += "," + DoubleToString((velas[1].close - velas[1].low),0);//4
      // se for alta, retracao positiva
      data += "," + DoubleToString((velas[1].high - velas[1].open),0); //3
    }
   data  += "," + DoubleToString(RSI_Buffer[1],2);//5
   data  += "," + DoubleToString(mm_um_Buffer[1]-mm_cinco_Buffer[1],2);//6
   data  += "," + DoubleToString(mm_um_Buffer[1]-mm_quinze_Buffer[1],2);//7
   data  += "," + DoubleToString(mm_quinze_Buffer[1]-mm_cinco_Buffer[1],2);//8
   data  += "," + DoubleToString(ADX_B[1],2);//9
   data  += "," + DoubleToString(ATR_B[1],2);//10
   data  += "," + DoubleToString(MMO_B[1],2);//11
   data  += "," + DoubleToString(FORCE_B[1],2);//12
   //data  += "," + DoubleToString(OBV_B[1],2);//13 ->mudou
   data  += "," + DoubleToString(VOL_B[1],2);//14 
   data  += "," + DoubleToString(CCI_B[1],2);//15 
   data  += "," + DoubleToString(BEARS_B[1],2);//16
   data  += "," + DoubleToString(BULLS_B[1],2);//17
   data  += "," + DoubleToString(STOCK1_B[1],2);//18
   data  += "," + DoubleToString(STOCK2_B[1],2);//19
   data  += "," + DoubleToString(WILLIANS_B[1],2);//20
   data  += "," + DoubleToString(STD_B[1],2);//21
   //data  += "," + DoubleToString(AC_B[1],2);//22 ->mudou
   data  += "," + DoubleToString(MFI_B[1],2);//23
   data  += "," + DoubleToString(BBANDS1_B[1],2);//24
   data  += "," + DoubleToString(BBANDS2_B[1],2);//25
   data  += "," + DoubleToString(BBANDS3_B[1],2);//26
   
   return data;
}