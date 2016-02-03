/*
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

/*`
 *    ModelPerformanceChartInteractiveView.java
 *    Copyright (C) 2002-2015 University of Waikato, Hamilton, New Zealand
 *
 */

package weka.gui.knowledgeflow.steps;

import weka.core.Defaults;
import weka.core.Settings;
import weka.core.WekaException;
import weka.gui.knowledgeflow.BaseInteractiveViewer;
import weka.gui.visualize.PlotData2D;
import weka.gui.visualize.VisualizePanel;
import weka.gui.visualize.VisualizeUtils;
import weka.knowledgeflow.steps.ModelPerformanceChart;

import javax.swing.JButton;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.List;

/**
 * @author Mark Hall (mhall{[at]}pentaho{[dot]}com)
 * @version $Revision: $
 */
public class ModelPerformanceChartInteractiveView extends BaseInteractiveViewer {

  private static final long serialVersionUID = 8818417648798221980L;
  protected JButton m_clearButton = new JButton("Clear results");
  protected VisualizePanel m_visPanel = new VisualizePanel();

  protected static final String ID =
    "weka.gui.knowledgeflow.steps.ModelPerformanceChartInteractiveView";

  @Override
  public String getViewerName() {
    return "Model Performance Chart";
  }

  @Override
  public void init() throws WekaException {
    addButton(m_clearButton);
    add(m_visPanel, BorderLayout.CENTER);

    m_clearButton.addActionListener(new ActionListener() {
      @Override
      public void actionPerformed(ActionEvent e) {
        m_visPanel.removeAllPlots();
        m_visPanel.validate();
        m_visPanel.repaint();

        // clear all plot data/offscreen plot data
        ((ModelPerformanceChart) getStep()).clearPlotData();
      }
    });

    List<PlotData2D> plotData = ((ModelPerformanceChart) getStep()).getPlots();
    try {
      m_visPanel.setMasterPlot(plotData.get(0));

      for (int i = 1; i < plotData.size(); i++) {
        m_visPanel.addPlot(plotData.get(i));
      }

      if (((ModelPerformanceChart) getStep()).isDataIsThresholdData()) {
        m_visPanel.setXIndex(4);
        m_visPanel.setYIndex(5);
      }
    } catch (Exception ex) {
      throw new WekaException(ex);
    }
    m_visPanel.setPreferredSize(new Dimension(800, 600));
    applySettings(getSettings());
  }

  @Override
  public Defaults getDefaultSettings() {
    Defaults d = new VisualizeUtils.VisualizeDefaults();
    d.setID(ID);

    return d;
  }

  @Override
  public void applySettings(Settings settings) {
    m_visPanel.applySettings(settings, ID);
  }
}